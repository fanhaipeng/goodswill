require 'test_helper'
require 'config/routes.rb'

class RoutingTest < ActionController::TestCase
  test "/donation/index should be ok" do
    assert_generates '/donation/index',
      :controller => 'donation', :action => 'index'

    assert_recognizes({ :controller => 'donation', :action => 'index'},
      { :path => '/donation/index', :method => :get })
    assert_recognizes({ :controller => 'donation', :action => 'index'},
      { :path => '/donation', :method => :get })
  end

  test "/donation/new should be ok" do
    assert_routing '/donation/new', 
      :controller => 'donation', :action => 'new'
  end

  test "/donation/create should be ok" do
    assert_recognizes({:controller => 'donation', :action => 'create'},
      {:path => '/donation/create', :method => :post})
  end

  test "/donation/edit/:id should be ok" do
    assert_routing '/donation/edit/12',
      :controller => 'donation', :action => 'edit', :id => '12'
  end

  test "/donation/update/:id should be ok" do
    assert_recognizes({:controller => 'donation', :action => 'update', :id => '12'}, 
                      {:path => '/donation/update/12', :method => :put})
  end

  test "/donation/show/:id should be ok" do
    assert_routing '/donation/show/12',
      :controller => 'donation', :action => 'show', :id => '12'
  end
end
