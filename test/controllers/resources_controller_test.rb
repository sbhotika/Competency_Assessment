require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  # Test all resource controller actions and methods
  setup do
    create_paradigms
    create_resources
    create_users
    # Stub the session creation so the controller methods can be accessed
    # from behind the authentication
    resource_controller = @controller
    @controller = SessionsController.new
    post :create, {username:"admin", password:"password"}
    @controller = resource_controller
  end

  # Test that the index page displays with proper variables assigned
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paradigms)
    assert_not_nil assigns(:active_resources)
    assert_not_nil assigns(:inactive_resources)
  end

  # Test that the show page displays with proper object assigned
  test "should show resource" do
    get :show, id: @comm_dumm
    assert_not_nil assigns(:resource)
    assert_response :success
  end

  # Test that the new page displays
  test "should get new" do
    get :new
    assert_response :success
  end

  # Test that the create action actually creates a valid object
  test "should create resource" do
    assert_difference('Resource.count', 1) do
      post :create, resource: { title: "Test Resource", paradigm_id: 1, link: "http://wwww.google.com" , active: true}
    end

    assert_redirected_to resource_path(assigns(:resource))
  end

  # Test that the create action doesn't create an invalid object
  test "should not create invalid resource" do
    assert_no_difference('Resource.count') do
      post :create, resource: { title: "bad resource", paradigm_id: "asd", link: "", active: true}
    end

    assert_response :success
    assert_template 'new'
  end

  # Test that the edit page displays with the proper object assigned
  test "should get edit" do
    get :edit, id: @comm_dumm
    assert_not_nil assigns(:resource)
    assert_response :success
  end

  # Test that the udpate action actually udpates a valid object
  test "should update resource" do
    patch :update, id: @busi_success, resource: { title: "Test Resource Description Updated" }
    assert_redirected_to resource_path(assigns(:resource))
  end

  # Test that the update action doesn't update an invalid object
  test "should not update invalid resource" do
    patch :update, id: @busi_success, resource: { title: "" }

    assert_response :success
    assert_template 'edit'
  end

  # Test that the destroy action actually destroys the object
  test "should destroy resource" do
    assert_difference('Resource.count', -1) do
      delete :destroy, id: @busi_success
    end

    assert_redirected_to resources_path
  end

end
