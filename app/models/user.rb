class User < ActiveRecord::Base
  has_one :contact
  has_many :relationships
  has_many :contacts, :through => :relationships
  has_many :active_contacts, :through => :relationships, :class_name => "Contact", :source => :contact, :conditions => {:active => true}

  attr_accessible :name, :email, :password, :password_confirmation, :admin

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :name

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end 

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def new_random_password
    self.password = ActiveSupport::SecureRandom.base64(6)
    self.password_confirmation = self.password
  end
end
