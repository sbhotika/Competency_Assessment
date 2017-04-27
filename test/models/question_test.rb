require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # Test Relationships
  should have_many(:indicator_questions)
  should have_many(:indicators).through(:indicator_questions)

  # Basic Validations
  should validate_presence_of(:question)

  should allow_value("A question?").for(:question)
  should_not allow_value("").for(:question)

  # Scope and method tests
  context "With a proper context, " do
    setup do
      create_competencies
      create_levels
      create_indicators
      create_questions
      create_indicator_questions
    end

    teardown do
      remove_competencies
      remove_levels
      remove_indicators
      remove_questions
      remove_indicator_questions
    end

    should "Create all factory questions" do
      assert_equal false, @communication_q1.nil?
      assert_equal "When I have something to say, I prepare by organizing my thoughts and outlining my intention.", @communication_q1.question
      assert_equal "I pay attention and focus when someone is talking to me.", @communication_q2.question
      assert_equal "I can recognize non-verbal cues from others.", @communication_q3.question
    end

    should "Show all Active Questions" do
      assert_equal [@decision_making_q2, @decision_making_q1, @communication_q2, @communication_q1], Question.active.alphabetical
    end

    should "Show all Inactive Questions" do
      assert_equal [@communication_q3, @problem_solving_q1], Question.inactive.alphabetical
    end

    should "Show in alphabetical order" do
      assert_equal [@decision_making_q2, @communication_q3, @problem_solving_q1, @decision_making_q1,
                    @communication_q2, @communication_q1], Question.alphabetical
    end

    should "Show all questions for a certain competency" do
      assert_equal [@communication_q3, @communication_q2, @communication_q1], Question.for_competency(@communication.id).alphabetical
      assert_equal [@decision_making_q2, @decision_making_q1], Question.for_competency(@decision_making.id).alphabetical
      assert_equal [@problem_solving_q1], Question.for_competency(@problem_solving.id).alphabetical
    end

    should "delete all associated indicator_questions when a question is deleted" do
      assert_equal 2,@communication_q1.indicator_questions.count
      assert_equal false,@communication_q1.indicator_questions.first.nil?
      assert_equal false,@communication_q1.indicator_questions.last.nil?
      @communication_q1.destroy
      assert_equal true, @communication_q1.indicator_questions.first.nil?
      assert_equal true, @communication_q1.indicator_questions.last.nil?
    end

  end
end
