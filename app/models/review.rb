class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :content

  def self.recent_reviews
    Review.all.order("created_at DESC").limit(6)
  end
end