class Business < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name, :description, :image_url

  def self.search_by_name(search_term)
    where("lower(name) LIKE ?", "%#{search_term}%".downcase).order("created_at DESC")
  end
end