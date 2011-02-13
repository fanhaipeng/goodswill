class ReceiversController < ApplicationController

  before_filter :admin_user_required, :only => [:index, :edit, :update, :destroy]

  def page
    @page_name = params[:page]
    @sub_title = @page_name.gsub(/_/, ' ')
  end

  def index
    @receivers = Receiver.all
    @sub_title = "Index of receivers"
  end

  def new
    @receiver = Receiver.new
    @sub_title = "Request to become a receiver"
  end

  def create
    @receiver = Receiver.new(params[:receiver])
    flash[:notice] = nil
    respond_to do |format|
      if @receiver.save
        flash[:notice] = "Your request has been submitted, we'll contact you later."
        format.html { redirect_to receiver_path(@receiver)}
      else
        format.html { render :action => :new }
      end
    end
  end

  def edit
    @receiver = Receiver.find_by_id(params[:id])
    @sub_title = "Edit a receiver"
  end

  def update
    @receiver = Receiver.find_by_id(params[:id])
    respond_to do |format|
      if @receiver.update_attributes(params[:receiver])
        format.html { redirect_to receiver_path(@receiver) }
      else
        format.html { render :action => :edit }
      end
    end
  end

  def show
    @receiver = Receiver.find_by_id(params[:id])
    if not @receiver
      render 'public/404.html', :status => 404
    else
      @sub_title = "Receiver #{@receiver.name}"
    end
  end

  def destroy
    @receiver = Receiver.find_by_id(params[:id])
    flash[:error] = nil
    respond_to do |format|
      begin
        @receiver.destroy
        format.html { redirect_to receivers_path }
      rescue => e
        flash[:error] = "Fail to delete this record!"
        format.html { render :action => :show }
      end
    end
  end
end
