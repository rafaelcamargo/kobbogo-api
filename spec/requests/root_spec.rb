require 'rails_helper'

RSpec.describe 'Root requests' do
  it 'should return an API overview' do
    get '/'
    body = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(body).to eq({
      'resources' => {
        'users' => {
          'uri' => '/users',
          'description' => 'Creates an user'
        },
        'auth' => {
          'uri' => '/auth',
          'description' => 'Authenticates an user'
        },
        'todos' => {
          'uri' => '/todos',
          'description' => 'Creates, retrieves and deletes todos for an authenticated user'
        }
      },
      'learn_more' => 'https://github.com/rafaelcamargo/kobbogo-api#usage'
    })
  end
end
