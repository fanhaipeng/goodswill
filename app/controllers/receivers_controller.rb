class ReceiversController < ApplicationController
  def index
    @receivers = Receiver.all
  end

  def new
    @receiver = Receiver.new
  end

  def create
    @receiver = Receiver.new(params[:receiver])
    respond_to do |format|
      if @receiver.save
        format.html { redirect_to receiver_path(@receiver)}
      else
        format.html { render :action => :new }
      end
    end
  end

  def edit
    @receiver = Receiver.find_by_id(params[:id])
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
    end
  end

  def destroy
    @receiver = Receiver.find_by_id(params[:id])
    @receiver.destroy
    respond_to do |format|
      format.html { redirect_to receivers_path }
    end
  end
end