require 'test_helper'

class SortControllerTest < ActionController::TestCase

  test "index of sort should be ok" do
    session[:user_id] = users(:user_one)
    get :index
    assert_response :success
    assert assigns(:donations)
    for d in assigns(:donations)
      assert Donation::PICKED, d.status
    end
    assert assigns(:sub_title)
  end

  test "anonymous user can't see index" do
    get :index
    assert_redirected_to account_login_path
  end

  test "show of sort should be ok" do
    session[:user_id] = users(:user_one)
    get :show, :id => donations(:donation_one)
    assert_response :success
    assert assigns(:donation)
    assert assigns(:receivers)
    assert assigns(:sub_title)
  end

  test "anonymous user cant'see show" do
    get :show, :id => donations(:donation_one)
    assert_redirected_to account_login_path
  end

  test "update of sort should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference("DonationNote.count") do
      assert_difference("Delivery.count", 2) do
        put :update,:id => donations(:donation_three), :items => { "0" => { :id => "5", :dest => "1"}, "1" => { :id => "6", :dest => "4"} }
      end
    end
    assert_redirected_to sort_index_path
  end

  test "update of sort should be ok for existing delivery" do
    session[:user_id] = users(:user_two)
    assert_difference("DonationNote.count") do
      assert_no_difference("Delivery.count") do
        put :update, :id => donations(:donation_three), :items => { "0" => {:id => "5", :dest => "3"}, "1" => {:id => "6", :dest => "3"}}
      end
    end
  end

  test "anonymous user can't do update" do
    put :update, :id => donations(:donation_three), :items => { "0" => {:id => "5", :dest => "3"}, "1" => {:id => "6", :dest => "3"}}
    assert_redirected_to account_login_path
  end

end
