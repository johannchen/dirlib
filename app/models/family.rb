class Family < ActiveRecord::Base
  attr_accessible :name, :image, :description
  has_many :contacts

  mount_uploader :image, ImageUploader

  validates_uniqueness_of :name
end
