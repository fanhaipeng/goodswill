class HomeController < ApplicationController
  def index
    @latest_news = News.all(:order => :updated_at, :limit => 3) 
    @latest_items = Item.all(:order => :created_at, :limit => 5)
    @sub_title = "Home"
  end
end
