require 'test_helper'

class LevelTest < ActiveSupport::TestCase
  # Test Relationships
  should have_many(:indicators)

  # Basic Validations
  should validate_presence_of(:name)
  should validate_presence_of(:description)
  should validate_presence_of(:ranking)
  should validate_uniqueness_of(:ranking)
  should validate_numericality_of(:ranking)

  should allow_value("Champion").for(:name)
  should_not allow_value("").for(:name)
  should allow_value("Champion Description").for(:description)
  should_not allow_value("").for(:description)
  should allow_value(1).for(:ranking)
  should_not allow_value("").for(:ranking)
  should_not allow_value("Level1").for(:ranking)
  should_not allow_value(1.5).for(:ranking)


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
      assert_equal false, @novice.nil?
      assert_equal "Contributor", @contributor.name
      assert_equal "Champion", @champion.name
      assert_equal "Companion", @companion.name
    end

    # test uniqueness of ranking
    should "not be able to create a Level with an existing ranking" do
      bad_level = FactoryGirl.build(:level, name: "Bad Level", ranking: 3)
      deny bad_level.valid?
    end

    # test uniqueness of name
    should "not be able to create a Level with an existing name" do
      bad_level = FactoryGirl.build(:level, name: "Contributor", ranking: 7)
      deny bad_level.valid?
    end

    # test alphabetical scope
    should "have levels listed alphabetically" do
      assert_equal ["Champion", "Companion", "Contributor", "Novice"], Level.alphabetical.map { |e| e.name }
    end

    # test by_ranking scope
    should "have levels listed by ranking" do
      assert_equal ["Champion", "Contributor", "Companion", "Novice"], Level.by_ranking.map { |e| e.name }
    end

    # test active scope
    should "have all active levels" do
      assert_equal ["Champion", "Companion", "Contributor"], Level.active.alphabetical.map { |e| e.name }
    end

    # test inactive scope
    should "have all inactive levels" do
      assert_equal ["Novice"], Level.inactive.alphabetical.map { |e| e.name }
    end

    should "delete all indicators associated" do
      assert_equal 1, Indicator.for_level("Champion").count
      @champion.destroy
      assert_equal 0, Indicator.for_level("Champion").count
    end

  end
end
