class NewsController < ApplicationController

  before_filter :admin_user_required, :except => [:index, :show]

  def index
    @all_news = News.order("created_at desc")
    if params[:id]
      @selected_news = News.find_by_id(params[:id])
    else
      @selected_news = @all_news[0]
    end
  end

  def new
    @news = News.new
    @news.images.build
  end

  def create
    @news = News.new(params[:news])
    respond_to do |format|
      if @news.save
        format.html { redirect_to news_path(@news) }
      else
        format.html { render :action => :new }
      end
    end
  end

  def edit
    @news = News.find_by_id(params[:id])
  end

  def update
    @news = News.find_by_id(params[:id])
    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to news_path(@news) }
      else
        format.html { render :action => :edit }
      end
    end
  end

  def show
    @news = News.find_by_id(params[:id])
  end

  def destroy
    @news = News.find_by_id(params[:id])
    respond_to do |format|
      @news.destroy
      format.html { redirect_to news_index_path }
    end
  end

end
