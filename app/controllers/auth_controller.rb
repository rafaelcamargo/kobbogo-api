class AuthController < ApplicationController
  def create
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      render json: {
        token: token,
        exp: auth_expiration_timestamp,
        username: @user.username
      }, status: 201
    else
      render json: { error: 'User or Password invalid' }, status: :unauthorized
    end
  end

  private

  def token
    Services::JsonWebToken.encode(user_id: @user.id)
  end

  def auth_expiration_timestamp
    (Time.now + 24.hours.to_i).strftime("%m-%d-%Y %H:%M")
  end
end