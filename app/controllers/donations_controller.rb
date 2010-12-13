class DonationsController < ApplicationController
  def index
    @donations = Donation.all
  end

  def new
    @donation = Donation.new
    @donation.items.build
    @donation.images.build
  end

  def create
    @donation = Donation.new(params[:donation])
    respond_to do |format|
      if @donation.save
        format.html { redirect_to donation_path(@donation) }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @donation = Donation.find_by_id(params[:id])
  end

  def update
    @donation = Donation.find_by_id(params[:id])

    respond_to do |format|
      if @donation.update_attributes(params[:donation])
        format.html { redirect_to donation_path(@donation) }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def show
    @donation = Donation.find_by_id(params[:id])
    if not @donation
      render 'public/404.html', :status => 404
    end
  end

  def destroy
    @donation = Donation.find_by_id(params[:id])
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_path }
    end
  end
end
