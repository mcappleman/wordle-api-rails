require "test_helper"

class WordlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wordle = wordles(:one)
  end

  test "should get index" do
    get wordles_url, as: :json
    assert_response :success
  end

  test "should create wordle" do
    assert_difference("Wordle.count") do
      post wordles_url, params: { wordle: { status: @wordle.status } }, as: :json
    end

    assert_response :created
  end

  test "should show wordle" do
    get wordle_url(@wordle), as: :json
    assert_response :success
  end

  test "should update wordle" do
    patch wordle_url(@wordle), params: { wordle: { status: @wordle.status } }, as: :json
    assert_response :success
  end

  test "should destroy wordle" do
    assert_difference("Wordle.count", -1) do
      delete wordle_url(@wordle), as: :json
    end

    assert_response :no_content
  end
end
