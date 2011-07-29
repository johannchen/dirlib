class Family < ActiveRecord::Base
  attr_accessible :name, :image, :description, :dad, :mom
  has_many :contacts

  mount_uploader :image, ImageUploader

  validates_uniqueness_of :name

  def children
    Contact.where(:id => self.contact_ids - [dad, mom])
  end
 
  def dad_contact 
    Contact.find(dad) if dad
  end

  def mom_contact 
    Contact.find(mom) if mom
  end

  def info
    info = ''
    # parents names and email
    unless dad.blank?
      info << "#{dad_contact.all_name}<br />"
      info << "#{dad_contact.email}<br />" 
    end
    
    unless mom.blank?
      info << "#{mom_contact.all_name}<br />"
      info << "#{mom_contact.email}<br />"
    end

    # children names
    unless children.blank?
      children.each do |child|
        info << "#{child.all_name}<br />"
        # info << "#{child.email}<br />" unless child.email.blank?
      end
    end 

    # home address 
    info << "#{dad_contact.address}<br />" unless dad.blank?

    # home phone
    info << "#{dad_contact.home_phone}<br />" unless dad.blank?

    info.html_safe
  end 
end
