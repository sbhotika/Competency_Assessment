require 'test_helper'

class CompetencyTest < ActiveSupport::TestCase
  # Test Relationships
  should have_many(:indicators)


  # Basic Validations
  should validate_presence_of(:name)
  should validate_presence_of(:description)

  should allow_value("Communication").for(:name)
  should_not allow_value("").for(:name)


  # Scope and method tests
  context "With a proper context, " do
    setup do
      create_competencies
      create_levels
      create_paradigms
      create_indicators
      create_questions
      create_resources
      create_indicator_resources
      create_indicator_questions
    end

    teardown do
      remove_competencies
      remove_levels
      remove_paradigms
      remove_indicators
      remove_questions
      remove_resources
      remove_indicator_resources
      remove_indicator_questions
    end

    # Test that objects are created properly
    should "show that all factory objects are properly created" do
      assert_equal false, @communication.nil?
      assert_equal "Communication", @communication.name
      assert_equal "Decision Making", @decision_making.name
      assert_equal "Problem Solving", @problem_solving.name
    end

    # test alphabetical scope
    should "have competenices listed alphabetically" do
      assert_equal ["Communication", "Decision Making", "Problem Solving"], Competency.alphabetical.map { |e| e.name }
    end

    # test active scope
    should "have all active competencies" do
      assert_equal ["Communication", "Decision Making"], Competency.active.alphabetical.map { |e| e.name }
    end

    # test inactive scope
    should "have all inactive competencies" do
      assert_equal ["Problem Solving"], Competency.inactive.alphabetical.map { |e| e.name }
    end

    should "destroy all dependents when a competency is destroyed" do
      assert_equal false, @communication.destroyed?
      assert_equal false, @communication.indicators.first.destroyed?
      assert_equal false, @communication.indicators.first.resources.first.destroyed?
      assert_equal false, @communication.indicators.first.questions.first.destroyed?
      assert_equal false, @communication.indicators.first.indicator_questions.first.nil?
      assert_equal false, @communication.indicators.first.indicator_resources.first.nil?
      @communication.destroy
      assert_equal true, @communication.destroyed?
      assert_equal true, @communication.indicators.first.destroyed?
      assert_equal true, @communication.indicators.first.resources.first.destroyed?
      assert_equal true, @communication.indicators.first.questions.first.destroyed?
      assert_equal true, @communication.indicators.first.indicator_questions.first.nil?
      assert_equal true, @communication.indicators.first.indicator_resources.first.nil?
    end

  end

end
