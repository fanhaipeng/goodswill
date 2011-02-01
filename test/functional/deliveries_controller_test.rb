require 'test_helper'

class DeliveriesControllerTest < ActionController::TestCase

  test "Index of open deliveries should be ok" do
    session[:user_id] = users(:user_two)
    get:index, :s => Delivery::OPEN
    assert_response :success
    assert 2, assigns(:deliveries).length
    for d in assigns(:deliveries)
      assert Delivery::OPEN, d.status
    end
    assert assigns(:sub_title)
  end

  test "anonymous user can't see index" do
    get :index, :s => "open"
    assert_redirected_to account_login_path
  end

  test "show delivery should be ok" do
    session[:user_id] = users(:user_two)
    get :show, :id => deliveries(:delivery_one)
    assert_response :success
    assert_equal deliveries(:delivery_one).id, assigns(:delivery).id
    assert assigns(:delivery_notes)
    assert assigns(:sub_title)
  end

  test "print pack should be ok" do 
    session[:user_id] = users(:user_two)
    get :print_pack, :id => deliveries(:delivery_one)
    assert_response :success
    assert assigns(:delivery)
  end

  test "pack delivery should be ok" do
    session[:user_id] = users(:user_two)
    assert 2, deliveries(:delivery_six).items.length
    assert_difference("DeliveryNote.count") do
      put :pack, :id => deliveries(:delivery_six), :items => { "0" => { :id => "7", :include => true }, "1" => { :id => "8", :include => false }}, :note => 'one item does not meet quality bar'
    end
    assert 1, deliveries(:delivery_six).items.length
    assert_redirected_to deliveries_path
  end

  test "print ship should be ok" do
    session[:user_id] = users(:user_two)
    get :print_ship, :id => deliveries(:delivery_three)
    assert_response :success
    assert assigns(:delivery)
  end

  test "ship delivery should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference("DeliveryNote.count") do
      put :update, :id => deliveries(:delivery_three), :delivery => {:status => Delivery::SHIPPED}
    end
    assert_redirected_to deliveries_path(:s => Delivery::PACKED)
  end

end
