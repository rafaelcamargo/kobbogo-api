require 'rails_helper'

RSpec.describe "Auth requests" do
  it 'should return a response containg token, expiration date, and username on auth success' do
    username = 'camargo'
    password = '123'
    post '/users', :params => { :username =>  username, :password => password }
    post '/auth', :params => { :username => username, :password => password }
    body = JSON.parse(response.body)
    expires_at = (Time.now + 24.hours.to_i).strftime("%m-%d-%Y %H:%M")
    expect(body['token'].length).to eq(155)
    expect(body['exp']).to eq(expires_at)
    expect(body['username']).to eq(username)
    expect(response.status).to eq(201)
  end

  it 'should return unauthorized if user does not exist' do
    post '/auth', :params => { :username => 'taylor', :password => '123' }
    body = JSON.parse(response.body)
    expect(body['error']).to eq('User or Password invalid')
    expect(response.status).to eq(401)
  end

  it 'should return unauthorized if password does not match' do
    username = 'robert'
    password = '123'
    post '/users', :params => { :username =>  username, :password => password }
    post '/auth', :params => { :username => username, :password => '456' }
    body = JSON.parse(response.body)
    expect(body['error']).to eq('User or Password invalid')
    expect(response.status).to eq(401)
  end
end
