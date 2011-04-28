class Group < ActiveRecord::Base
  has_many :contact_groups, :dependent => :delete_all
  has_many :contacts, :through => :contact_groups
end
