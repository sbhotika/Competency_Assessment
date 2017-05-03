require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  # Test all question controller actions and methods
  setup do
    create_questions
    create_users
    # Stub the session creation so the controller methods can be accessed
    # from behind the authentication
    question_controller = @controller
    @controller = SessionsController.new
    post :create, {username:"admin", password:"password"}
    @controller = question_controller
  end

  # Test that the index page displays with proper variables assigned
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:active_questions)
    assert_not_nil assigns(:inactive_questions)
  end

  # Test that the show page displays with proper object assigned
  test "should show question" do
    get :show, id: @communication_q1
    assert_not_nil assigns(:question)
    assert_response :success
  end

  # Test that the new page displays
  test "should get new" do
    get :new
    assert_response :success
  end

  # Test that the create action actually creates a valid object
  test "should create question" do
    assert_difference('Question.count', 1) do
      post :create, question: { question: "Test Question" }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  # Test that the create action doesn't create an invalid object
  test "should not create invalid question" do
    assert_no_difference('Question.count') do
      post :create, question: { question: "" }
    end

    assert_response :success
    assert_template 'new'
  end

  # Test that the edit page displays with the proper object assigned
  test "should get edit" do
    get :edit, id: @communication_q1
    assert_not_nil assigns(:question)
    assert_response :success
  end

  # Test that the udpate action actually udpates a valid object
  test "should update question" do
    patch :update, id: @communication_q1, question: { question: "Test Question 2" }
    assert_redirected_to question_path(assigns(:question))
  end

  # Test that the update action doesn't update an invalid object
  test "should not update invalid question" do
    patch :update, id: @communication_q1, question: { question: "" }

    assert_response :success
    assert_template 'edit'
  end

  # Test that the destroy action actually destroys the object
  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @communication_q1
    end

    assert_redirected_to questions_path
  end
end
