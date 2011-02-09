class PickUpController < ApplicationController

  before_filter :admin_user_required

  def index
    @donations = Donation.where(:status => Donation::INITIAL)
    @sub_title = "Donations to pick up"
  end

  def show
    @donation = Donation.find_by_id(params[:id])
    @donation_notes = DonationNote.where(:donation_id => params[:id])
    @sub_title = "Donation by #{@donation.name} to pick up"
  end

  def update
    @donation = Donation.find_by_id(params[:id])
    respond_to do |format|
      if @donation.update_attributes(params[:donation])
        add_donation_note(@donation.id, params[:donation_note])
        format.html { redirect_to pick_up_index_path }
      else
        flash[:error] = "Error occured while updating donation's status, try later again"
        @donation_notes = DonationNote.where(:donation_id => params[:id])
        format.html { render :controller => :pick_up, :action => show }
      end
    end
  end

  private

  def add_donation_note(donation_id, note_params)
    user = User.find_by_id(session[:user_id])
    note_text = note_params[:note]
    note_text << " (picked up by #{user.name} at #{Time.now.strftime("%m/%d/%Y %H:%M:%S")})"
    note = DonationNote.new(note_params)
    note.donation_id = donation_id
    note.user_id = session[:user_id]
    note.note = note_text
    note.save
  end
end
