class DeliveriesController < ApplicationController

  before_filter :admin_user_required

  def index
    @deliveries = Delivery.where(:status => params[:s].to_i)
  end

  def show
    @delivery = Delivery.find_by_id(params[:id])
  end

  def update
  end

  def print_pack
    @delivery = Delivery.find_by_id(params[:id])
  end

  def pack
    note_text = ""
    for item_param in params[:items]
      dispose_item item_param[1][:id], note_text unless item_param[1][:include]
    end
    @delivery = Delivery.find_by_id(params[:id])
    user = User.find_by_id(session[:user_id])
    @delivery.update_attribute(:status, Delivery::PACKED)
    note_text << "<p>Packed by #{user.name} at #{Time.now.strftime("%m/%d/%Y %H:%M:%S")}.</p>"
    note_text << "<p>Comment: #{params[:note]}.</p>" if params[:note]
    add_delivery_note params[:id], note_text
    respond_to do |format|
      format.html { redirect_to deliveries_path(:s => Delivery::OPEN) }
    end
  end

  private

  def dispose_item item_id, note_text
    item = Item.find_by_id(item_id)
    if item.donation.discard
      item.update_attributes(:status => Item::DISPOSED, :delivery_id => nil)
      note_text << "<p>Item #{item_id} was disposed.</p>"
    else
      item.update_attributes(:status => Item::WITHDREW, :delivery_id => nil)
      note_text << "<p>Item #{item_id} was withdrawn.</p>"
    end
  end

  def add_delivery_note delivery_id, note_text
    note = DeliveryNote.create(:user_id => session[:user_id], :delivery_id => delivery_id, :note => note_text)
  end
end

