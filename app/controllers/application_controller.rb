class ApplicationController < ActionController::API
  before_action :set_locale

  def set_locale
    I18n.locale = extract_lang_from_locale(client_locale)
  end

  def authorize_request
    encoded_token = request.headers['Authorization']
    begin
      decoded_token = Services::JsonWebToken.decode(encoded_token)
      @current_user = User.find(decoded_token[:user_id])
    rescue StandardError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def client_locale
    request.headers['Accept-Language'] || 'en'
  end

  def extract_lang_from_locale(locale)
    locale.split('-')[0].to_sym
  end
end
