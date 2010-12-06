class DonationComment < ActiveRecord::Base
  validates_presence_of :donation_id, :comment
end
