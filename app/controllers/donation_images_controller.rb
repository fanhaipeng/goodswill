class DonationImagesController < ApplicationController

  def show
    @image = DonationImage.find_by_id(params[:id])
    send_data @image.data, :type => @image.image_type
  end

end
