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
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def four_ninety_eight(e)
    json_response({ message: e.message }, :invalid_token)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end
