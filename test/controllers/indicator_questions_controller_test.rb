require 'test_helper'

class IndicatorQuestionsControllerTest < ActionController::TestCase
  # Test all IndicatorQuestionsController methods

  setup do
    create_competencies
    create_levels
    create_indicators
    create_questions
    create_indicator_questions
  end

  # Test that the create action creates a valid object
  test "should create indicator_question" do
    assert_difference('IndicatorQuestion.count', 1) do
      post :create, indicator_question: { indicator_id: @indicator5, question_id: @communication_q1 }
    end
    assert_redirected_to question_path(assigns(:question))
  end

  # Test that the create action does not create an invalid object
  test "should not create invalid indicator_question missing an indicator" do
    assert_no_difference('IndicatorQuestion.count') do
      post :create, indicator_question: { question_id: @communication_q1 }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  # Test that the destroy action destroys the object
  test "should destroy indicator_question mapping" do
    assert_difference('IndicatorQuestion.count', -1) do
      delete :destroy, id: @indicator5_problem_solving_q1
    end

    assert_redirected_to question_path(assigns(:question))
  end

end
