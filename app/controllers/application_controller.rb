class ApplicationController < ActionController::API
  skip_before_action :authorize_request, only: :authenticate, raise: false

  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end
end
