class DeliveryImagesController < ApplicationController
  
  before_filter :admin_user_required, :except => :show

  def create
    @img = DeliveryImage.new(params[:delivery_image])
    @img.delivery_id = params[:delivery_id]
    respond_to do |format|
      if not @img.save
        flash[:error] = "All fields of the image can't be blank"
      end
      format.html { redirect_to delivery_path(params[:delivery_id]) }
    end
  end

  def show
    @img = DeliveryImage.find_by_id(params[:id])
    send_data @img.data, :type => @img.image_type
  end

  def destroy
    @img = DeliveryImage.find_by_id(params[:id])
    @img.destroy
    respond_to do |format|
      format.html { redirect_to delivery_path(params[:delivery_id])}
    end
  end

end
