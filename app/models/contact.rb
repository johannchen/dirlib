class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :family
  has_many :relationships, :dependent => :delete_all
  has_many :users, :through => :relationships
  has_many :contact_groups, :dependent => :delete_all
  has_many :groups, :through => :contact_groups
  has_many :contact_statuses, :dependent => :delete_all
  has_many :statuses, :through => :contact_statuses
  has_many :books

  validates_presence_of :first_name, :last_name, :gender
  validates_uniqueness_of :email, :allow_nil => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_numericality_of :cell_phone, :work_phone, :home_phone, :allow_blank => true
  validates_length_of :cell_phone, :work_phone, :home_phone, :is => 10, :allow_blank => true

  scope :active, where(:active => true).order("first_name")
  scope :active_non_user, where("user_id is null and email is not null and active is true").order("first_name")

  def self.search(search)
    where(['first_name like ? or last_name like ?', "%#{search}%", "%#{search}%"]).order("first_name") if search
  end

  def address
    a = ''
    a << "#{address_line_1}" unless address_line_1.blank?
    a << ", #{address_line_2}" unless address_line_2.blank?
    unless city.blank? or state.blank?
      a << "<br /> #{city}, #{state}"
      a << " #{zip}" unless zip.blank?
    end 
    a.html_safe
  end

  def name
    first_name + " " + last_name
  end

  def name_email
    name + " - " + email
  end

  def group_names
    self.groups.map(&:name).join(', ') if self.groups
  end

  def family_name
    family.name if family
  end

  def family_name=(name)
    self.family = Family.find_or_create_by_name(name) unless name.blank?
  end

  def family_members
    self.family.contacts.map(&:first_name).join(', ') if self.family_id
  end
end
