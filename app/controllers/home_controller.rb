class HomeController < ApplicationController
  def index
    @latest_news = News.order("created_at desc").limit(3)
    @sub_title = "Home"
  end
end
