require 'spec_helper'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:business) }

  describe "recent_reviews" do
    it "returns an empty array if there are no reviews" do
      expect(Review.recent_reviews).to eq([])
    end

    it "returns all reviews if there are 6 or less reviews" do
      3.times { Fabricate(:review) }
      expect(Review.recent_reviews.count).to eq(3)
    end

    it "returns a maximum of 6 reviews if there are more than 6 reviews" do
      7.times { Fabricate(:review) }
      expect(Review.recent_reviews.count).to eq(6)
    end

    it "returns reviews in reverse chronological order" do
      review1 = Fabricate(:review, created_at: 1.day.ago)
      review2 = Fabricate(:review)
      expect(Review.recent_reviews).to eq([review2, review1])
    end

    it "returns the most recent 6 reviews" do
      old_review = Fabricate(:review, created_at: 1.day.ago)
      6.times { Fabricate(:review) }
      expect(Review.recent_reviews).not_to include(old_review)
    end
  end
end