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
end
