require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @authentication = authentication(:one)
  end

  test "should get index" do
    get authentication_url, as: :json
    assert_response :success
  end

  test "should create authentication" do
    assert_difference("Authentication.count") do
      post authentication_url, params: { authentication: {} }, as: :json
    end

    assert_response :created
  end

  test "should show authentication" do
    get authentication_url(@authentication), as: :json
    assert_response :success
  end

  test "should update authentication" do
    patch authentication_url(@authentication), params: { authentication: {} }, as: :json
    assert_response :success
  end

  test "should destroy authentication" do
    assert_difference("Authentication.count", -1) do
      delete authentication_url(@authentication), as: :json
    end

    assert_response :no_content
  end
end
