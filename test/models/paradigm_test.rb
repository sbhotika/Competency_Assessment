require 'test_helper'

class ParadigmTest < ActiveSupport::TestCase

  # Relationships
  should have_many(:resources)

  # Validation tests
  should validate_presence_of(:name)
  should validate_presence_of(:description)
  should validate_presence_of(:ranking)
  should validate_numericality_of(:ranking)
  should validate_uniqueness_of(:ranking)
  should validate_uniqueness_of(:name)

  context "With a proper context," do
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

    should "Create all test objects properly" do
      assert_equal false, @build_understanding.nil?
      assert_equal "Do Something", @do_something.name
      assert_equal "Get Connected", @get_connected.name
      assert_equal "Learn More", @learn_more.name
    end

    # test alphabetical scope
    should "Show paradigms in alphabetical order" do
      assert_equal ["Build Understanding", "Do Something", "Get Connected", "Learn More"], Paradigm.alphabetical.map { |e| e.name}
    end

    # test by_ranking scope
    should "Show paradigms in ascending ranking" do
      assert_equal ["Build Understanding", "Get Connected", "Do Something", "Learn More"], Paradigm.by_ranking.map { |e| e.name}
    end

    should "delete resources when a paradigm is deleted" do
      assert_equal 1, @build_understanding.resources.count
      @build_understanding.destroy
      assert_equal 0,@build_understanding.resources.count
    end

  end

end
