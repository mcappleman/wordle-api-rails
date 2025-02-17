module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
  end

  private

  def four_twenty_two(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def four_ninety_eight(e)
    render json: { message: e.message }, status: :invalid_token
  end

  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end
