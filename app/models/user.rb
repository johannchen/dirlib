class User < ActiveRecord::Base
  has_one :contact
  has_many :relationships
  has_many :contacts, :through => :relationships
  has_many :posts
  has_many :books
  has_many :messages

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :admin, :contact_tokens, :active

  attr_reader :contact_tokens
  attr_accessor :password
  before_save :encrypt_password

  scope :active, where(:active => true).order("admin DESC, first_name")

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email

  def contact_tokens=(ids)
    self.contact_ids = ids.split(",")
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) && user.active
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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64 
    end while User.exists?(column => self[column])
  end

  def name
    first_name + " " + last_name
  end
end
