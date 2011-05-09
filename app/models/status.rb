class Status < ActiveRecord::Base
  has_many :contact_statuses, :dependent => :delete_all
  has_many :contacts, :through => :contact_statuses
end
