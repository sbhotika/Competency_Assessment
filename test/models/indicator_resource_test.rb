require 'test_helper'

class IndicatorResourceTest < ActiveSupport::TestCase
  # Test Relationships
  should belong_to(:indicator)
  should belong_to(:resource)

  # Basic Validations
  should validate_presence_of(:indicator_id)
  should validate_presence_of(:resource_id)
  should validate_numericality_of(:indicator_id)
  should validate_numericality_of(:resource_id)

  # Scope and method tests
  context "With a proper context, " do
    setup do
      create_competencies
      create_levels
      create_indicators
      create_paradigms
      create_resources
      create_indicator_resources
    end

    teardown do
      remove_competencies
      remove_levels
      remove_indicators
      remove_paradigms
      remove_resources
      remove_indicator_resources
    end

  end

end
