class ContactStatus < ActiveRecord::Base
  belongs_to :contact
  belongs_to :status
end
