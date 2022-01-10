require 'rails_helper'

RSpec.describe "Todos requests" do
  it 'should save a todo' do
    post '/todos', :params => { :description =>  'Testing description'}
    expect(response.status).to eq(201)
  end

  it 'should not save a todo if description is missing' do
    post '/todos'
    body = JSON.parse(response.body)
    expect(response.status).to eq(400)
    expect(body['errors']).to include("Description can't be blank")
  end

  it 'should not save a todo if an unknown error is thrown' do
    error_message = "Unknown error"
    todo = instance_double(Todo)
    allow(Todo).to receive(:new).and_return(todo)
    allow(todo).to receive(:save).and_raise(StandardError, error_message)
    post '/todos', :params => { :description =>  'Testing description'}
    body = JSON.parse(response.body)
    expect(response.status).to eq(500)
    expect(body['errors']).to include(error_message)
  end

  it 'should query todos' do
    get '/todos'
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq([])
    article = create :todo
    get '/todos'
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq([
      {
        "id" => article.id,
        "description" => article.description,
        "created_at" => article.created_at.as_json,
        "updated_at" => article.updated_at.as_json
      }
    ])
  end

  it 'should render an error if an error is thrown on query' do
    error_message = "Some other error"
    todo = instance_double(Todo)
    allow(Todo).to receive(:all).and_raise(StandardError, error_message)
    get '/todos'
    body = JSON.parse(response.body)
    expect(response.status).to eq(500)
    expect(body['errors']).to include(error_message)
  end
end
