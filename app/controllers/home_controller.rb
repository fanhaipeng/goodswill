class HomeController < ApplicationController
  def index
    @latest_news = News.order("updated_at desc").limit(3)
    @sub_title = "Home"
  end
end
