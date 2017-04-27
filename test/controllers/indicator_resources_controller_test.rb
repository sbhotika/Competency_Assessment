require 'test_helper'

class IndicatorResourcesControllerTest < ActionController::TestCase
  # Test all IndicatorResourcesController methods

  setup do
    create_competencies
    create_levels
    create_indicators
    create_paradigms
    create_resources
    create_indicator_resources
  end

  # Test that create action creates a valid object
  test "should create indicator_resource" do
    assert_difference('IndicatorResource.count', 1) do
      post :create, indicator_resource: { indicator_id: @indicator5, resource_id: @comm_dumm}
    end

    assert_redirected_to indicator_path(assigns(:indicator))
  end

  # Test that create action does not create an invalid object
  test "should not create invalid indicator_resource missing a resource" do
    assert_no_difference('IndicatorResource.count') do
      post :create, indicator_resource: { indicator_id: @indicator5 }
    end

    assert_redirected_to indicator_path(assigns(:indicator))
  end

  # Test that the destroy action destroys
  test "should destroy indicator_resource mapping" do
    assert_difference('IndicatorResource.count', -1) do
      delete :destroy, id: @indicator5_busi_success
    end

    assert_redirected_to indicator_path(assigns(:indicator))
  end


end
