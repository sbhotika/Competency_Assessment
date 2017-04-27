require 'test_helper'

class ResourceTest < ActiveSupport::TestCase

  # Test Relationships
  should belong_to(:paradigm)
  should have_many(:indicator_resources)
  should have_many(:indicators).through(:indicator_resources)

  # Test Validations
  should validate_presence_of(:title)
  should validate_presence_of(:paradigm_id)

  # Test scopes
  context "With a proper context" do
    setup do
      create_competencies
      create_paradigms
      create_levels
      create_resources
      create_indicators
      create_indicator_resources
    end

    teardown do
      remove_competencies
      remove_resources
      remove_levels
      remove_paradigms
      remove_indicators
      remove_indicator_resources
    end

    should "show that all resources are created properly" do
      assert_equal false, @comm_dumm.nil?
      assert_equal "How to Succeed in Business", @busi_success.title
      assert_equal "How to Fail in Business", @busi_failure.title
      assert_equal "Public Speaking 101 Workshop", @pub_speak.title
    end

    should "have all resources listed alphabetically" do
      assert_equal ["Communication Skills for Dummies", "How to Fail in Business", "How to Succeed in Business", "Public Speaking 101 Workshop"], Resource.alphabetical.map  { |e| e.title }
    end

    should "show links are formated properly" do
      assert_equal "http://www.google.com", @comm_dumm.link
      assert_equal "https://www.google.com", @busi_success.link
      assert_equal "", @busi_failure.link
      assert_equal nil, @pub_speak.link
    end

    should "delete associated indicator_resources when resources are deleted" do
      assert_equal 1,@comm_dumm.indicator_resources.count
      assert_equal false, @comm_dumm.indicator_resources.first.nil?
      @comm_dumm.destroy
      assert_equal true, @comm_dumm.indicator_resources.first.nil?
    end

  end

end
