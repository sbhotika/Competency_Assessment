require 'test_helper'

class LevelsControllerTest < ActionController::TestCase
  # Test all level controller actions and methods
  setup do
    create_levels
    create_users
    # Stub the session creation so the controller methods can be accessed
    # from behind the authentication
    level_controller = @controller
    @controller = SessionsController.new
    post :create, {username:"admin", password:"password"}
    @controller = level_controller
  end

  # Test that the index page displays with proper variables assigned
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:active_levels)
    assert_not_nil assigns(:inactive_levels)
  end


  # Test that the new page displays
  test "should get new" do
    get :new
    assert_response :success
  end

  # Test that the create action actually creates a valid object
  test "should create level" do
    assert_difference('Level.count', 1) do
      post :create, level: { name: "Test Level", description: "Test Level Description", ranking: 99 }
    end

    assert_redirected_to level_path(assigns(:level))
  end

  # Test that the create action doesn't create an invalid object
  test "should not create invalid level" do
    assert_no_difference('Level.count') do
      post :create, level: { name: "Bad Level", description: "Bad Test Level Description", ranking: 1 }
    end

    assert_response :success
    assert_template 'new'
  end

  # Test that the edit page displays with the proper object assigned
  test "should get edit" do
    get :edit, id: @champion
    assert_not_nil assigns(:level)
    assert_response :success
  end

  # Test that the udpate action actually udpates a valid object
  test "should update level" do
    patch :update, id: @champion, level: { name: "Champion2" }
    assert_redirected_to level_path(assigns(:level))
  end

  # Test that the update action doesn't update an invalid object
  test "should not update invalid level" do
    patch :update, id: @champion, level: { name: "" }

    assert_response :success
    assert_template 'edit'
  end

  # Test that the destroy action actually destroys the object
  test "should destroy level" do
    assert_difference('Level.count', -1) do
      delete :destroy, id: @champion
    end

    assert_redirected_to levels_path
  end
end
