class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :content, :category_id

  def self.search(search)
    where(['title like ?', "%#{search}%"]).order("created_at desc") if search 
  end

end
