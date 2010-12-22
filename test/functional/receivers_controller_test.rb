require 'test_helper'

class ReceiversControllerTest < ActionController::TestCase

  fixtures :receivers

  test "index of receivers should be ok" do
    get :index
    assert_response :success
    assert assigns(:receivers)
  end

  test "new page of receiver should be ok" do
    get :new
    assert_response :success
    assert assigns(:receiver)
  end

  test "create a receiver should be ok" do
    assert_difference("Receiver.count") do
      post :create, :receiver => 
      {
        :name => 'any name',
        :introduction => 'any text',
        :address => 'any addres',
        :phone => '13812345678',
        :email => 'goodswill@live.com',
      }
    end
    assert assigns(:receiver)
    assert_redirected_to receiver_path(assigns(:receiver).id)
  end

  test "invalid reciever model fails creation" do
    assert_no_difference("Receiver.count") do
      post :create, :receiver => 
      {
        :name => 'any name',
        :introduction => 'any text',
        :address => 'any addres',
        :phone => '1381234567', # bad phone number
        :email => 'goodswill@live.com',
      }
    end
    assert_response :success
    assert assigns(:receiver)
  end

  test "edit receiver should be ok" do
    get :edit, :id => receivers(:receiver_one)
    assert_response :success
    assert assigns(:receiver)
    assert_equal receivers(:receiver_one), assigns(:receiver)
  end

  test "update receiver should be ok" do
    put :update, :id => receivers(:receiver_one), :receiver => 
    {
      :address => 'another address'
    }
    assert_redirected_to receiver_path(receivers(:receiver_one))
    assert_equal 'another address', assigns(:receiver).address
  end

  test "show receiver should be ok" do
    get :show, :id => receivers(:receiver_two)
    assert_response :success
    assert assigns(:receiver)
    assert_equal receivers(:receiver_two), assigns(:receiver)
  end

  test "delete receiver should be ok" do
    assert_difference("Receiver.count", -1) do
      delete :destroy, :id => receivers(:receiver_one)
    end
    assert_redirected_to receivers_path
  end

  test "404 should be returned if no receiver is found" do
    get :show, :id => 9999
    assert_response :missing
  end

end
