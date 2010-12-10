class NewsImagesController < ApplicationController
  def create
    @news = News.find_by_id(params[:news_id])

    # TODO: check if @news exists
    
    @img = Image.new(params[:image])
    respond_to do |format|
      if @img.save
        @news.images << @img
      else
        flash[:image_error] = @img.errors.full_messages.to_s
      end
      format.html { redirect_to news_path(@news) }
    end
  end

  def show
    @news = News.find_by_id(params[:news_id])
    @img = Image.find_by_id(params[:id])

    # TODO: check if @news and @img exist and they're related
    send_data @img.data, :type => @img.image_type
  end

  def destroy
    @news = News.find_by_id(params[:news_id])
    @img = Image.find_by_id(params[:id])

    # TODO: check if @news and @img exist and they're related
    @news.images.delete(@img)
    @img.destroy
    
    respond_to do |format|
      format.html { redirect_to news_path(@news) }
    end
  end
end
