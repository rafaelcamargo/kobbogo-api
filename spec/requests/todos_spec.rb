require 'rails_helper'

RSpec.describe "Todos requests" do
  before(:all) do
    username = 'todouser'
    password = '123'
    post '/users', :params => { :username =>  username, :password => password }
    post '/auth', :params => { :username =>  username, :password => password }
    body = JSON.parse(response.body)
    @token = body['token']
  end

  it 'should save a todo' do
    post '/todos', :params => { :description =>  'Testing description'}, :headers => { :Authorization => @token }
    expect(response.status).to eq(201)
  end

  it 'should save a todo if no auth token has been provided' do
    post '/todos', :params => { :description =>  'Testing description'}
    expect(response.status).to eq(401)
  end

  it 'should not save a todo if description is missing' do
    post '/todos', :headers => { :Authorization => @token }
    body = JSON.parse(response.body)
    expect(response.status).to eq(400)
    expect(body['errors']).to include("Description can't be blank")
  end

  it 'should render an error if an unknown error is thrown' do
    error_message = "Unknown error"
    todo = instance_double(Todo)
    allow(Todo).to receive(:new).and_return(todo)
    allow(todo).to receive(:save).and_raise(StandardError, error_message)
    post '/todos', :params => { :description =>  'Testing description'}, :headers => { :Authorization => @token }
    body = JSON.parse(response.body)
    expect(response.status).to eq(500)
    expect(body['errors']).to include(error_message)
  end

  it 'should query todos based on given token' do
    post '/users', :params => { :username =>  'Bob', :password => '123' }
    post '/auth', :params => { :username =>  'Bob', :password => '123' }
    first_token = JSON.parse(response.body)['token']
    post '/users', :params => { :username =>  'Joe', :password => '456' }
    post '/auth', :params => { :username =>  'Joe', :password => '456' }
    second_token = JSON.parse(response.body)['token']
    post '/todos', :params => { :description =>  'First user\'s first todo'}, :headers => { :Authorization => first_token }
    post '/todos', :params => { :description =>  'First user\'s second todo'}, :headers => { :Authorization => first_token }
    post '/todos', :params => { :description =>  'Second user\'s first todo'}, :headers => { :Authorization => second_token }
    get '/todos', :headers => { :Authorization => second_token }
    body = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(body.length).to eq(1)
    expect(body[0]['description']).to eq('Second user\'s first todo')
  end

  it 'should not return user id on todos query' do
    post '/users', :params => { :username =>  'bob', :password => '123' }
    post '/auth', :params => { :username =>  'bob', :password => '123' }
    token = JSON.parse(response.body)['token']
    post '/todos', :params => { :description =>  'Testing'}, :headers => { :Authorization => token }
    get '/todos', :headers => { :Authorization => token }
    body = JSON.parse(response.body)
    expect(body[0]['user_id']).to eq(nil)
  end

  it 'should render an error if an unknown error is thrown on query' do
    error_message = "Some other error"
    todo = instance_double(Todo)
    allow(Todo).to receive(:all).and_raise(StandardError, error_message)
    get '/todos', :headers => { :Authorization => @token }
    body = JSON.parse(response.body)
    expect(response.status).to eq(500)
    expect(body['errors']).to include(error_message)
  end
end
