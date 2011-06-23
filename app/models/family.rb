class Family < ActiveRecord::Base
  attr_accessible :name, :image, :description, :dad, :mom
  has_many :contacts

  mount_uploader :image, ImageUploader

  validates_uniqueness_of :name
 
  def dad_contact 
    Contact.find(dad) if dad
  end

  def mom_contact 
    Contact.find(mom) if mom
  end

  def info
    info = ''
    # parents names
    info << "#{dad_contact.all_name}<br />" unless dad.blank?
    info << "#{mom_contact.all_name}<br />" unless mom.blank?

    # children names

    # home address 
    info << "#{dad_contact.address}<br />" unless dad.blank?

    # parents emails
    info << "#{dad_contact.email}<br />" unless dad.blank?
    info << "#{mom_contact.email}<br />" unless mom.blank?

    # home phone
    info << "#{dad_contact.home_phone}<br />" unless dad.blank?

    info.html_safe
  end 
end
