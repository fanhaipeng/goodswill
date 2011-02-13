class DonationsController < ApplicationController

  before_filter :admin_user_required, :only => [:index, :edit, :update, :destroy]

  def page
    @page_name = params[:page]
    @sub_title = @page_name.gsub(/_/, ' ') 
  end

  def index
    @donations = Donation.order("created_at desc")
    @sub_title = "Index of all donations"
  end

  def new
    @donation = Donation.new
    1.upto(3) { @donation.items.build }
    @donation.images.build
    @sub_title = "Create a new donation"
  end

  def create
    @donation = Donation.new(params[:donation])
    flash[:notice] = nil
    respond_to do |format|
      if @donation.save
        flash[:notice] = "Your donation form has been submitted successfully, thank you for your kindness!"
        format.html { redirect_to donation_path(@donation) }
      else
        1.upto(3) { @donation.items.build } if @donation.items.length ==0
        @donation.images.build if @donation.images.length == 0
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @donation = Donation.find_by_id(params[:id])
    @sub_title = "Edit donation"
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
    else
      @sub_title = "Donation by #{@donation.name}"
    end
  end

  def destroy
    @donation = Donation.find_by_id(params[:id])
    flash[:error] = nil
    respond_to do |format|
      begin
        @donation.destroy
      rescue
        flash[:error] = "Fail to delete this donation recored!"
        format.html{ render :action => :show }
      end
      format.html { redirect_to donations_path }
    end
  end

  def query
    @sub_title = "Search donations"
  end

  def search
    @donations = Donation.where(:email => params[:email], :phone => params[:phone], :name => params[:name]).order("created_at desc")
    @sub_title = "Donation search results"
    flash[:error] = nil
    respond_to do |format|
      if @donations.length > 0
        format.html { render :action => :search }
      else
        flash[:error] = "No donation found. Donation record can only be found by exactly matching these fields."
        format.html { render :action => :query}
      end
    end
  end
end
