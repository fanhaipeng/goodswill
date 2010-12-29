class SortController < ApplicationController

  before_filter :admin_user_required

  def index
    @donations = Donation.where(:status => Donation::PICKED)
  end

  def show
    @donation = Donation.find_by_id(params[:id])
    @donation_notes = @donation.notes
    @receivers = Receiver.where( :approved => true )
  end

  def update
    for item_param in params[:items]
      sort item_param[1]
    end
    add_donation_note(params[:id], params[:note])
    donation = Donation.find_by_id(params[:id])
    donation.update_attribute(:status, Donation::SORTED)
    respond_to do |format|
      format.html { redirect_to sort_index_path }
    end
  end

  private

  def sort item_param
    delivery = Delivery.where(:receiver_id => item_param["dest"], :status => Delivery::OPEN).first
    item = Item.find_by_id(item_param["id"]) 
    delivery = Delivery.create(:receiver_id => item_param["dest"]) unless delivery
    item.update_attribute(:delivery_id, delivery.id) 
  end

  def add_donation_note(id, note_param)
    user = User.find_by_id(session[:user_id])
    note_text = "Sorted by #{user.name} at #{Time.now.strftime("%m/%d/%Y %H:%M:%S")} | "
    note_text << note_param if note_param
    note = DonationNote.create(:user_id => user.id, :donation_id => id, :note => note_text)
  end

end
