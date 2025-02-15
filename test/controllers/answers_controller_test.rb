require "test_helper"

class AnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @answer = answers(:one)
  end

  test "should get index" do
    get answers_url, as: :json
    assert_response :success
  end

  test "should create answer" do
    assert_difference("Answer.count") do
      post answers_url, params: { answer: {} }, as: :json
    end

    assert_response :created
  end

  test "should show answer" do
    get answer_url(@answer), as: :json
    assert_response :success
  end

  test "should destroy answer" do
    assert_difference("Answer.count", -1) do
      delete answer_url(@answer), as: :json
    end

    assert_response :no_content
  end
end
