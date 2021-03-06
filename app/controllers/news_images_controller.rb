class NewsImagesController < ApplicationController

  before_filter :admin_user_required, :except => :show
  def create
    @img = NewsImage.new(params[:news_image])
    @img.news_id = params[:news_id]
    respond_to do |format|
      if not @img.save
        flash[:error] = ""
        @img.errors.each {|k, v| flash[:error] << "#{k} #{v}<br/>"}
      end
      format.html { redirect_to news_path(params[:news_id]) }
    end
  end

  def show
    @img = NewsImage.find_by_id(params[:id])
    send_data @img.data, :type => @img.image_type
  end

  def destroy
    @img = NewsImage.find_by_id(params[:id])
    @img.destroy
    respond_to do |format|
      format.html { redirect_to news_path(params[:news_id])}
    end
  end

end
