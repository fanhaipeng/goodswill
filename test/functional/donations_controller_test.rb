require 'test_helper'

class DonationsControllerTest < ActionController::TestCase

  # tests for donations
  
  test "index of donations should be ok" do
    session[:user_id] = users(:user_two)
    get :index
    assert_response :success
    assert assigns(:donations)
    assert assigns(:sub_title)
  end

  test "anonymous user can't see index" do
    get :index
    assert_redirected_to account_login_path 
  end

  test "new donation should be ok" do
    get :new
    assert_response :success
    assert assigns(:donation)
    assert assigns(:sub_title)
  end

  test "create donation should be ok" do
    assert_difference('Donation.count') do
      assert_difference('Item.count', 2) do
        post :create, :donation =>
        create_donation(
          create_item_params, 
          create_image_params
        )
      end
    end
    assert assigns(:donation)
    assert_redirected_to donation_path(assigns(:donation).id)
    assert flash[:notice]
  end

  test "edit donation should be ok" do
    session[:user_id] = users(:user_two)
    get :edit, :id => donations(:donation_two).to_param
    assert_response :success
    assert assigns(:donation)
    assert_equal donations(:donation_two).id, assigns(:donation).id
    assert assigns(:sub_title)
  end
  
  test "update donation should be ok" do
    session[:user_id] = users(:user_two)
    put :update, :id => donations(:donation_one), :donation => { :phone => '020-12345678' }
    assert_redirected_to donation_path(donations(:donation_one))
  end

  test "show donation should be ok" do
    get :show, :id => donations(:donation_one).to_param
    assert_response :success
    assert assigns(:donation)
    assert_equal 2, assigns(:donation).items.length
    assert assigns(:sub_title)
  end

  test "404 should return when donation is not found" do
    get :show, :id => 9999
    assert_response :missing
  end

  test "delete donation should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference('Donation.count', -1) do 
      delete :destroy, :id => donations(:donation_one).to_param
    end
    assert_redirected_to donations_path
  end

  test "anonymous user can't see edit page" do
    get :edit, :id => donations(:donation_two).to_param
    assert_redirected_to account_login_path
  end

  test "anonymous user can't update donation" do
    put :update, :id => donations(:donation_one), :donation => { :phone => '020-12345678' }
    assert_redirected_to account_login_path
  end

  test "anonymous user can't delete donation" do
    assert_no_difference('Donation.count') do 
      delete :destroy, :id => donations(:donation_one).to_param
    end
    assert_redirected_to account_login_path
  end

  # tests for items

  test "blank items should be ignored" do
    assert_difference("Donation.count") do
      assert_difference('Item.count', 2) do
        post :create, :donation =>
          create_donation(
            { 
              "0" => {:category => nil, :quantity => nil}, 
              "1" => {:category => 'two', :quantity => 20},
              "2" => {:category => 'three', :quantity => 3} 
            },
            create_image_params
          ) 
        end
    end
    assert assigns(:donation)
    assert_redirected_to donation_path(assigns(:donation).id)
  end

  test "partial blank item should fail donation create" do
    assert_no_difference("Donation.count") do
      assert_no_difference("Item.count") do
        post :create, :donation =>
          create_donation(
            {
              "0" => {:category => nil, :quantity => 1}
            },
            create_image_params
          )
      end
    end
    assert assigns(:donation)
    assert assigns(:donation).errors.any?
  end

  test "add item to existing donation should be ok" do
    session[:user_id] = users(:user_two)
    assert_no_difference("Donation.count") do
      assert_difference("Item.count") do
        put :update, :id => donations(:donation_one), 
          :donation => 
          { :items_attributes => 
            { "0" => 
              { 
                :category => 'new category', 
                :quantity => 1 
              }
            }
          }
      end
    end
    assert_redirected_to donation_path(donations(:donation_one))
  end

  test "update items of donation should be ok" do
    session[:user_id] = users(:user_two)
    assert_no_difference("Donation.count") do
      assert_no_difference("Item.count") do
        put :update, :id => donations(:donation_one),
          :donation => 
          {
            :items_attributes =>
            {
              "0" =>
              {
                :id => items(:item_one).id,
                :category => 'new category one',
                :unit => 'new unit'
              },
              "1" =>
              {
                :id => items(:item_two).id,
                :quantity => 100
              }              
            }
          }
      end
    end
    assert_redirected_to donation_path(donations(:donation_one))
  end

  test "delete item from existing donation should be ok" do
    session[:user_id] = users(:user_two)
    assert_no_difference("Donation.count") do
      assert_difference("Item.count", -1) do
        put :update, :id => donations(:donation_one),
          :donation => 
          {
            :items_attributes =>
            { "0" =>
              {
                :id => 1, :_destroy => true
              }
            }
          }
      end
    end
  end

  # tests for images

  test "blank images should be ignored" do
    assert_difference("Donation.count") do
      assert_difference("DonationImage.count") do
        post :create, :donation =>
          create_donation(
            create_item_params,
            { 
              "0" => {:image_data => nil}, 
              "1" => {:image_data => fixture_file_upload('/files/test1.jpg', 'image/jpeg')},
            }
          ) 
      end
    end
  end

  test "add image to existing donation should be ok" do
    session[:user_id] = users(:user_two)
    assert_no_difference("Donation.count") do
      assert_difference("DonationImage.count") do
        put :update, :id => donations(:donation_one), 
          :donation => 
          { :images_attributes => 
            { "0" => 
              { 
                :image_data => fixture_file_upload('/files/test3.png', 'image/png')
              }
            }
          }
      end
    end
    assert_redirected_to donation_path(donations(:donation_one))
  end

  test "update image of donation should be ok" do
    session[:user_id] = users(:user_two)
    assert_no_difference("Donation.count") do
      assert_no_difference("DonationImage.count") do
        put :update, :id => donations(:donation_one),
          :donation => 
          {
            :images_attributes =>
            {
              "0" =>
              {
                :id => donation_images(:donation_image_one).id,
              },
              "1" =>
              {
                :id => donation_images(:donation_image_two).id,
                :image_data => fixture_file_upload('/files/test2.jpg', 'image/jpeg')
              }              
            }
          }
      end
    end
    assert_redirected_to donation_path(donations(:donation_one))
  end

  test "delete image from existing donation should be ok" do
    session[:user_id] = users(:user_two)
    assert_no_difference("Donation.count") do
      assert_difference("DonationImage.count", -1) do
        put :update, :id => donations(:donation_one),
          :donation => 
          {
            :images_attributes =>
            { "0" =>
              {
                :id => donation_images(:donation_image_one).id, :_destroy => true
              }
            }
          }
      end
    end
  end

  # test for query/search

  test "query donation should be ok" do
    get :query
    assert_response :success
    assert assigns(:sub_title)
  end

  test "search donation should be ok" do
    get :search, :email => 'goodswill@live.com', :phone => '010-58963532', :name => 'Haipeng Fan'
    assert_response :success
    assert assigns(:donations)
    assert assigns(:sub_title)
  end

  test "search not found should go back to query" do
    get :search, :email => 'goodswill@live.com', :phone => '010-58963532', :name => 'wrong name'
    assert_response :success
    assert flash[:error]
    assert assigns(:sub_title)
  end

  test "show page from search should have back to search results link" do
    get :show, :id => donations(:donation_one), :mode => "search"
    assert_response :success
    assert assigns(:donation)
    assert_select "h3 a", { :count => 1, :text => "&lt;&lt; Back to search results" }
  end

  private 

  def create_donation(items, images)
    { :phone => '13811111111',
      :address => 'any address',
      :email => 'goodswill@live.com',
      :name => 'any name',
      :pick_up => false,
      :news_letter => true,
      :items_attributes => items,
      :images_attributes => images
    }
  end

  def create_item_params
    { 
      "0" => { :category => 'one', :quantity => 12 ,},
      "1" => { :category => 'two', :quantity => 2 }
    }
  end

  def create_image_params
    {
      "0" => { :image_data => fixture_file_upload('/files/test1.jpg', 'image/jpeg')},
      "1" => { :image_data => fixture_file_upload('/files/test2.jpg', 'image/png')}
    }
  end
end
