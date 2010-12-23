class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :email, :salt, :role, :password, :password_confirmation, :on => :create
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates_uniqueness_of :email

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypt_password(@password, self.salt)
  end

  def password
    @password
  end

  private

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypt_password(password, salt)
    string_to_hash = password + 'goodswill' + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user
      expected_password = encrypt_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

end
