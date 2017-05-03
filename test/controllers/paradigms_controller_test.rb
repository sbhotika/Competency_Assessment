require 'test_helper'

class ParadigmsControllerTest < ActionController::TestCase
  # Test all paradigm controller actions and methods
  setup do
    create_paradigms
    create_users
    # Stub the session creation so the controller methods can be accessed
    # from behind the authentication
    paradigm_controller = @controller
    @controller = SessionsController.new
    post :create, {username:"admin", password:"password"}
    @controller = paradigm_controller
  end

  # Test that the index page displays with proper variables assigned
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:active_paradigms)
    assert_not_nil assigns(:inactive_paradigms)
  end

  # Test that the new page displays
  test "should get new" do
    get :new
    assert_response :success
  end

  # Test that the create action actually creates a valid object
  test "should create paradigm" do
    assert_difference('Paradigm.count', 1) do
      post :create, paradigm: { name: "Test Paradigm", description: "Test Paradigm Description", ranking: 5 }
    end

    assert_redirected_to paradigm_path(assigns(:paradigm))
  end

  # Test that the create action doesn't create an invalid object
  test "should not create invalid paradigm" do
    assert_no_difference('Paradigm.count') do
      post :create, paradigm: { name: "", description: "Bad Test Paradigm Description", ranking: 5 }
    end

    assert_response :success
    assert_template 'new'
  end

  # Test that the edit page displays with the proper object assigned
  test "should get edit" do
    get :edit, id: @build_understanding
    assert_not_nil assigns(:paradigm)
    assert_response :success
  end

  # Test that the udpate action actually udpates a valid object
  test "should update paradigm" do
    patch :update, id: @build_understanding, paradigm: { name: "Test Paradigm 2" }
    assert_redirected_to paradigm_path(assigns(:paradigm))
  end

  # Test that the update action doesn't update an invalid object
  test "should not update invalid paradigm" do
    patch :update, id: @build_understanding, paradigm: { name: "" }

    assert_response :success
    assert_template 'edit'
  end

  # Test that the destroy action actually destroys the object
  test "should destroy paradigm" do
    assert_difference('Paradigm.count', -1) do
      delete :destroy, id: @build_understanding
    end

    assert_redirected_to paradigms_path
  end
end
