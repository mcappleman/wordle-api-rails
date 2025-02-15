require "test_helper"

class GuessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guess = guesses(:one)
  end

  test "should get index" do
    get guesses_url, as: :json
    assert_response :success
  end

  test "should create guess" do
    assert_difference("Guess.count") do
      post guesses_url, params: { guess: { word: @guess.word } }, as: :json
    end

    assert_response :created
  end

  test "should show guess" do
    get guess_url(@guess), as: :json
    assert_response :success
  end

  test "should update guess" do
    patch guess_url(@guess), params: { guess: { word: @guess.word } }, as: :json
    assert_response :success
  end

  test "should destroy guess" do
    assert_difference("Guess.count", -1) do
      delete guess_url(@guess), as: :json
    end

    assert_response :no_content
  end
end
