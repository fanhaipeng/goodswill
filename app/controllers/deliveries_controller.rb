class DeliveriesController < ApplicationController

  before_filter :admin_user_required
  layout :choose_layout

  def index
    @deliveries = Delivery.where(:status => params[:s].to_i).order("updated_at desc")
  end

  def show
    @delivery = Delivery.find_by_id(params[:id])
    @delivery_notes = DeliveryNote.where(:delivery_id => @delivery.id)
  end

  def update
    @delivery = Delivery.find_by_id(params[:id])
    current_status = @delivery.status
    respond_to do |format|
      if @delivery.update_attributes(params[:delivery])
        add_delivery_note(params[:id], build_note_per_status(@delivery.status, params[:note]))
      end
      format.html { redirect_to deliveries_path(:s => current_status) }
    end
  end

  def print_pack
    @delivery = Delivery.find_by_id(params[:id])
  end

  def pack
    user = User.find_by_id(session[:user_id])
    note_text = ""
    note_text << "<p>#{params[:note]}.</p>" if params[:note]
    note_text << "<p>packed by #{user.name} at #{get_timestamp}.</p>"
    for item_param in params[:items]
      dispose_item item_param[1][:id], note_text unless item_param[1][:include]
    end
    @delivery = Delivery.find_by_id(params[:id])
    @delivery.update_attribute(:status, Delivery::PACKED)
    add_delivery_note params[:id], note_text
    respond_to do |format|
      format.html { redirect_to deliveries_path }
    end
  end

  def print_ship
    @delivery = Delivery.find_by_id(params[:id])
  end

  private

  def dispose_item item_id, note_text
    item = Item.find_by_id(item_id)
    item.update_attributes(:status => Item::DISPOSED, :delivery_id => nil)
    note_text << "<p>item #{item_id} was disposed.</p>"
  end

  def add_delivery_note delivery_id, note_text
    note = DeliveryNote.create(:user_id => session[:user_id], :delivery_id => delivery_id, :note => note_text)
  end

  def get_timestamp
    Time.now.strftime("%m/%d/%Y %H:%M:%S")
  end

  def build_note_per_status status, note
    user = User.find_by_id(session[:user_id])
    action = case status
             when Delivery::SHIPPED then  "Shipped"
             when Delivery::CONFIRMED then "Confirmed"
             else raise "Unexpected status"
             end

    note_text = ""
    note_text << "<p>#{note}</p>" if note
    note_text << "<p>#{action} by #{user.name} at #{get_timestamp}</p>"
    note_text
  end

  def choose_layout
    if ['print_pack', 'print_ship'].include? action_name
      'print'
    else
      'application'
    end
  end
end

