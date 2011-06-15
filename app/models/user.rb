class User < ActiveRecord::Base
  has_one :contact
  has_many :relationships
  has_many :contacts, :through => :relationships
  has_many :posts
  has_many :books

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :admin, :contact_tokens

  attr_reader :contact_tokens
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email

  def contact_tokens=(ids)
    self.contact_ids = ids.split(",")
  end

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

  def name
    first_name + " " + last_name
  end
end
