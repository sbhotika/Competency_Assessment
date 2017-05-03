require 'test_helper'

class IndicatorsControllerTest < ActionController::TestCase
  # Test all indicator controller actions and methods
  setup do
    create_competencies
    create_levels
    create_indicators
    create_users
    # Stub the session creation so the controller methods can be accessed
    # from behind the authentication
    indicator_controller = @controller
    @controller = SessionsController.new
    post :create, {username:"admin", password:"password"}
    @controller = indicator_controller
  end

  # Test that the index page displays with proper variables assigned
  test "should get index" do
    get :index, :competency_id => 1
    assert_response :success
    assert_not_nil assigns(:competency)
  end

  # Test that the show page displays with proper object assigned
  test "should show indicator" do
    get :show, id: @indicator1
    assert_not_nil assigns(:indicator)
    assert_response :success
  end

  # Test that the new page displays
  test "should get new" do
    get :new
    assert_not_nil assigns(:active_competencies)
    assert_not_nil assigns(:active_levels)
    assert_response :success
  end

  # Test that the create action actually creates a valid object
  test "should create indicator" do
    assert_difference('Indicator.count', 1) do
      post :create, indicator: { description: "Test Indicator Description", level_id: 1, competency_id: 1 }
    end

    assert_redirected_to indicator_path(assigns(:indicator))
  end

  # Test that the create action doesn't create an invalid object
  test "should not create invalid indicator" do
    assert_no_difference('Indicator.count') do
      post :create, indicator: { description: "", level_id: 1, competency_id: 1 }
    end

    assert_response :success
    assert_template 'new'
  end

  # Test that the edit page displays with the proper object assigned
  test "should get edit" do
    get :edit, id: @indicator1
    assert_not_nil assigns(:indicator)
    assert_not_nil assigns(:active_competencies)
    assert_not_nil assigns(:active_levels)
    assert_response :success
  end

  # Test that the udpate action actually udpates a valid object
  test "should update indicator" do
    patch :update, id: @indicator2, indicator: { description: "Test Indicator Description 2" }
    assert_redirected_to indicator_path(assigns(:indicator))
  end

  # Test that the update action doesn't update an invalid object
  test "should not update invalid indicator" do
    patch :update, id: @indicator2, indicator: { description: "" }

    assert_response :success
    assert_template 'edit'
  end

  # Test that the destroy action actually destroys the object
  test "should destroy indicator" do
    assert_difference('Indicator.count', -1) do
      delete :destroy, id: @indicator2
    end

    assert_redirected_to indicators_path
  end
end
