class RootController < ApplicationController
  def index
    render json: overview, status: :ok
  end

  private

  def overview
    {
      resources: {
        users: {
          uri: '/users',
          description: 'Creates an user'
        },
        auth: {
          uri: '/auth',
          description: 'Authenticates an user'
        },
        todos: {
          uri: '/todos',
          description: 'Creates, retrieves and deletes todos for an authenticated user'
        }
      },
      learn_more: 'https://github.com/rafaelcamargo/kobbogo-api#usage'
    }
  end
end
