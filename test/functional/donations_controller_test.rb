require 'test_helper'

class DonationsControllerTest < ActionController::TestCase

  fixtures :donations
  fixtures :items

  test "index of donations should be ok" do
  end

  test "new donation should be ok" do
    get :new
    assert_response :success
    assert assigns(:donation)
  end

  test "create donation should be ok" do
    assert_difference('Donation.count') do
      assert_difference('Item.count', 2) do
        post :create, :donation =>
        { :phone => '13811111111',
          :address => 'any address',
          :email => 'goodswill@live.com',
          :name => 'any name',
          :track => false,
          :items_attributes => 
          { 
            "0" => { :category => 'one', :quantity => 12 },
            "1" => {:category => 'two', :quantity => 2 }
          }
        }
      end
    end
  end

  test "blank items should be ignored" do
    assert_difference('Donation.count') do
      assert_difference('Item.count', 2) do
        post :create, :donation =>
        { :phone => '13822222222',
          :address => 'any address',
          :email => 'goodswill@live.com',
          :name => 'any name',
          :track => false,
          :items_attributes => 
          { 
            "0" => {:category => nil, :quantity => nil}, 
            "1" => {:category => 'two', :quantity => 20},
            "2" => {:category => 'three', :quantity => 3} 
          }
        }
        end
    end
  end

  test "edit donation should be ok" do
    get :edit, :id => donations(:donation_two).to_param
    assert_response :success
    assert assigns(:donation)
    assert_equal donations(:donation_two).id, assigns(:donation).id
  end

  test "update donation should be ok" do
    put :update, :id => donations(:donation_one), :donation => { :phone => '020-12345678' }
    assert_redirected_to donations_path
  end

  test "show donation should be ok" do
    get :show, :id => donations(:donation_one).to_param
    assert_response :success
    assert assigns(:donation)
    assert assigns(:donation).items
  end

  test "404 should return when donation is not found" do
    get :show, :id => 9999
    assert_response :missing
  end

  test "delete donation should be ok" do
    assert_difference('Donation.count', -1) do 
      delete :destroy, :id => donations(:donation_one).to_param
    end
    assert_redirected_to donations_path
  end
end
