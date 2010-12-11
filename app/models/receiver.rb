class Receiver < ActiveRecord::Base
  belongs_to :image

  validates_presence_of :name, :introduction, :address, :phone, :email 
  validates_format_of :email, 
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => 'email address is invalid'
  validates_format_of :phone,
                      :with => /^1\d{10}$|^\d{2,4}-\d{7,8}$/,
                      :message => 'the phone number is invalid'

  attr_accessor :image_file

  after_validation do |model|
    if not (model.image_file or model.persisted?)
      false
    end
  end

  before_create do |model|
    if model.image_file 
      model.image_id = Image.create(:image_data => model.image_file, :description => model.name).id
    end
  end

  after_destroy do |model|
    Image.delete(model.image_id)
  end
                        
  before_update do |model|
    if model.image_file 
      @old_image_id = model.image_id
      model.image_id = Image.create(:image_data => model.image_file, :description => model.name).id
    end
  end

  after_update do |model|
    Image.delete(@old_image_id)
  end
  
end
