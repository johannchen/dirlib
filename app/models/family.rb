class Family < ActiveRecord::Base
  has_many :contacts

  validates_uniqueness_of :name
end
