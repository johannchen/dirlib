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

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  validates_numericality_of :cell_phone, :work_phone, :home_phone, :allow_blank => true
  validates_length_of :cell_phone, :work_phone, :home_phone, :is => 10, :allow_blank => true

  scope :members, where(:member => true)
  scope :with_email, where("email is not null and email != ''")
  scope :active, where(:active => true)
  scope :active_non_user, where("user_id is null").active.with_email.order("first_name")

  def self.search(search)
    where(['first_name like ? or last_name like ?', "%#{search}%", "%#{search}%"]).order("first_name") if search
  end

  def self.auto_complete(term)
    where(['first_name like ? or last_name like ?', "%#{term}%", "%#{term}%"]).with_email.order("first_name") if term
  end

  def self.printed_members
    f_ids = self.members.group(:family_id).map(&:id)
    m_ids = self.members.where(:family_id => nil).map(&:id)
    p_ids = f_ids + m_ids
    where(:id => p_ids).order(:last_name)
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

  def all_name
    other_name ? name + " " + other_name : name
  end

  def name_email
    name + " <" + email + ">"
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
