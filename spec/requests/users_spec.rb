require 'rails_helper'

RSpec.describe 'Users requests' do
  it 'should create an user' do
    post '/users', params: { username: 'rafael', password: '123' }
    expect(response.status).to eq(201)
  end

  it 'should not save an user if username is missing' do
    post '/users', params: { password: '123' }
    body = parse(response)
    expect(response.status).to eq(400)
    expect(body['errors']).to eq(["Username can't be blank"])
  end

  it 'should not save an user if password is missing' do
    post '/users', params: { username: 'rafael' }
    body = parse(response)
    expect(response.status).to eq(400)
    expect(body['errors']).to eq(["Password can't be blank"])
  end

  it 'should not save an user if username has already been taken' do
    user = { username: 'fernando', password: '123' }
    create(:user, user)
    post '/users', params: user
    body = parse(response)
    expect(response.status).to eq(400)
    expect(body['errors']).to eq(['Username has already been taken'])
  end

  it 'should not save an user if an unknown error is thrown' do
    error_message = 'Unknown error'
    user = instance_double(User)
    allow(User).to receive(:new).and_return(user)
    allow(user).to receive(:save).and_raise(StandardError, error_message)
    post '/users', params: { username: 'rafael', password: '123' }
    body = parse(response)
    expect(response.status).to eq(500)
    expect(body['errors']).to eq([error_message])
  end
end

def parse(response)
  JSON.parse(response.body)
end
