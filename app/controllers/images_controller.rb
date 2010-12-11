class ImagesController < ApplicationController
  def show
    @image = Image.find_by_id(params[:id])
    send_data @image.data, :type => @image.image_type
  end
end
