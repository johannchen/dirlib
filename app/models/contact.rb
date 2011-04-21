class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :relationships
  has_many :users, :through => :relationships
end
