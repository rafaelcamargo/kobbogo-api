class AuthController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      render json: {
        token: token,
        exp: auth_expiration_timestamp,
        username: @user.username
      }, status: :created
    else
      error_message = I18n.t 'auth.errors.invalid_credentials'
      render json: { errors: [error_message] }, status: :unauthorized
    end
  end

  private

  def token
    Services::JsonWebToken.encode(user_id: @user.id)
  end

  def auth_expiration_timestamp
    (Time.zone.now + 24.hours.to_i).strftime('%m-%d-%Y %H:%M')
  end
end
