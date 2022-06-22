class ApplicationController < ActionController::API
  def authorize_request
    encoded_token = request.headers['Authorization']
    begin
      decoded_token = Services::JsonWebToken.decode(encoded_token)
      @current_user = User.find(decoded_token[:user_id])
    rescue => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
