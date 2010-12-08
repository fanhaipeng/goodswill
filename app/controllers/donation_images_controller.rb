class DonationImagesController < ApplicationController

  def create
    @donation = Donation.find_by_id(params[:donation_id])

    # TODO: check if donation is found
    
    @image = Image.new(params[:image])
    respond_to do |format|
      if @image.save
        @donation.images << @image
      end
      format.html { redirect_to donation_path(@donation)}
    end

  end

  def show
    @donation = Donation.find_by_id(params[:donation_id])
    @image = Image.find_by_id(params[:id])

    # TODO: check if donation and image are found, and image is contained by donation
    
    send_data @image.data, :type => @image.image_type
  end

  def destroy
    @donation = Donation.find_by_id(params[:donation_id])
    @image = Image.find_by_id(params[:id])

    # TODO: check if donation and image are found, and image is contained by donation

    @donation.images.delete(@image)
    @image.destroy

    respond_to do |format|
      format.html { redirect_to donation_path(@donation)}
    end
  end

end
