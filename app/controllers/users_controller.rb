class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render status: 201
    else
      thrown_error(@user.errors.full_messages, 400)
    end
  rescue => e
    thrown_error(e.message, 500)
  end

  private

  def user_params
    params.permit(:username, :password)
  end

  def thrown_error(errors, status)
    render json: { errors: remove_unnecessary_errors(errors) }, status: status
  end

  def remove_unnecessary_errors(errors)
    Array(errors).select { |err| !err.include? 'Password digest' }
  end
end
