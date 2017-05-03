require 'test_helper'

class CompetenciesControllerTest < ActionController::TestCase
  # Test all competency controller actions and methods
  setup do
    create_competencies
    create_users
    # Stub the session creation so the controller methods can be accessed
    # from behind the authentication
    competency_controller = @controller
    @controller = SessionsController.new
    post :create, {username:"admin", password:"password"}
    @controller = competency_controller
  end

  # Test that the index page displays with proper variables assigned
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:active_competencies)
    assert_not_nil assigns(:inactive_competencies)
  end

  # Test that the show page displays with proper object assigned
  test "should show competency" do
    get :show, id: @communication
    assert_not_nil assigns(:competency)
    assert_response :success
  end

  # Test that the new page displays
  test "should get new" do
    get :new
    assert_response :success
  end

  # Test that the create action actually creates a valid object
  test "should create competency" do
    assert_difference('Competency.count', 1) do
      post :create, competency: { name: "Test Competency", description: "Test Competency Description" }
    end

    assert_redirected_to competency_path(assigns(:competency))
  end

  # Test that the create action doesn't create an invalid object
  test "should not create invalid competency" do
    assert_no_difference('Competency.count') do
      post :create, competency: { name: "", description: "Bad Test Competency Description" }
    end

    assert_response :success
    assert_template 'new'
  end

  # Test that the edit page displays with the proper object assigned
  test "should get edit" do
    get :edit, id: @communication
    assert_not_nil assigns(:competency)
    assert_response :success
  end

  # Test that the update action actually updates a valid object
  test "should update competency" do
    patch :update, id: @communication, competency: { name: "Test Competency 2" }
    assert_redirected_to competency_path(assigns(:competency))
  end

  # Test that the update action doesn't update an invalid object
  test "should not update invalid competency" do
    patch :update, id: @communication, competency: { name: "" }

    assert_response :success
    assert_template 'edit'
  end

  # Test that the destroy action actually destroys the object
  test "should destroy competency" do
    assert_difference('Competency.count', -1) do
      delete :destroy, id: @communication
    end

    assert_redirected_to competencies_path
  end
end
