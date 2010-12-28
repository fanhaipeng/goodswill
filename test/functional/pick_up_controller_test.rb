require 'test_helper'

class PickUpControllerTest < ActionController::TestCase
  test "index of pickup should be ok" do
    session[:user_id] = users(:user_two)
    get :index
    assert_response :success
    assert assigns(:donations)
  end

  test "anonymous user can't see index" do
    get :index
    assert_redirected_to account_login_path
  end

  test "show of pickup should be ok" do
    session[:user_id] = users(:user_two)
    get :show, :id => donations(:donation_one)
    assert_response :success
    assert assigns(:donation)
    assert assigns(:donation_notes)
  end

  test "anonymous user can't see show" do
    get :show, :id => donations(:donation_one)
    assert_redirected_to account_login_path
  end

  test "update status should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference("DonationNote.count") do
      put :update, :id => donations(:donation_one).id.to_s, :donation => { :status => Donation::PICKED }, :donation_note => { :note => "picked up by ourselves" }
    end
    assert_redirected_to pick_up_index_path
  end

  test "anonymous user can't do update" do
    put :update, :id => donations(:donation_one).id.to_s, :donation => { :status => Donation::PICKED }, :donation_note => { :note => "picked up by ourselves" }
    assert_redirected_to account_login_path
  end
end
