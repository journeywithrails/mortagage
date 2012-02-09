require 'digest/sha1'
class User < AccountModel
  belongs_to :account
  
  file_column :photo_file,
    :magick => { :versions => {
      :thumb => {:crop=>"1:1", :size=>"50x50!"}, 
      :medium => {:crop=>"1:1", :size=>"200x200!"} } }

  # Virtual attribute for the unencrypted password
  attr_accessor :password
  attr_accessor :login

  validates_presence_of     :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false 

  before_save :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :name, :email, :password, :password_confirmation,  
    :address1, :address2, :city, :state, :zip, :phone_work, :phone_mobile, :fax, 
    :photo_file, :delete_photo_file
  attr_accessor :delete_photo_file

    # need for file_column voodoo (from active_scaffold/lib/bridges/file_column.lib/file_column_helpers.rb)
  def delete_photo_file=(value)
    value = (value=="true") if String===value
    return unless value
    
    # passing nil to the file column causes the file to be deleted.  Don't delete if we just uploaded a file!
    self.photo_file = nil unless self.photo_file_just_uploaded?
  end
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def self.authenticate_with_crypted_password(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated_with_crypted_password?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  # used to authenticate against already crypted password
  def authenticated_with_crypted_password?(password)
    crypted_password == password
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  def self.random_password
    rand_password = ''
    space = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    (1..AppConfig['new_password_length']).each { rand_password += space.rand }
    rand_password
  end

  def reset_password
    new_password = User.random_password
    self.password = new_password
    self.password_confirmation = new_password
    self.save!
    new_password
  end

  def login
    self.email
  end
  
  def to_label
    "#{email}"
  end
  
  def save_last_login
    self.previous_login_at = !last_login_at.blank? ? last_login_at : Time.now
    self.last_login_at = Time.now
    self.save!
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
end
