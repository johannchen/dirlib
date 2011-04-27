class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :relationships
  has_many :users, :through => :relationships
  has_many :contact_groups
  has_many :groups, :through => :contact_groups

  # TODO: validation on birthday and others
  validates_presence_of :name, :gender
  validates_uniqueness_of :email, :allow_nil => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_numericality_of :cell_phone, :work_phone, :allow_blank => true
  validates_length_of :cell_phone, :work_phone, :is => 10, :allow_blank => true

  def self.search(search)
    where(['name like ?', "%#{search}%"]) if search
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

  #def birthday
  #  birthday.to_date if birthday
  #end
end