class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @donation = Donation.find_by_id(params[:donation_id])
    @comment.donation = @donation
    respond_to do |format|
      if not @comment.save
        flash[:error] = "Comment can't be blank"
      end
      format.html { redirect_to donation_path(@donation) }
    end
  end

  def destroy
    @donation = Donation.find_by_id(params[:donation_id])
    @comment = Comment.find_by_id(params[:id])
    respond_to do |format|
      if @comment.donation_id != @donation.id
        # TODO: set errors to @comment
        @comment.errors.add(:donation_id, 'this comment does not belong to the donation, you can''t delete it')
        format.html { redirect_to donation_path(@donation) }
      else
        @comment.destroy
        format.html { redirect_to donation_path(@donation) }
      end
    end
  end
end
