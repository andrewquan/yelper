require 'spec_helper'

describe Business do
  it { should have_many(:reviews) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:image_url) }

  describe "search_by_name" do
    it "returns an empty array if there is no match" do
      chipotle = Business.create(name: "Chipotle", description: "Mexican food.", image_url: "/tmp/chipotle.jpg")
      starbucks = Business.create(name: "Starbucks", description: "Coffee shop.", image_url: "/tmp/starbucks.jpg")
      expect(Business.search_by_name("hello")).to eq([])
    end

    it "returns an array of one business for an exact match" do
      chipotle = Business.create(name: "Chipotle", description: "Mexican food.", image_url: "/tmp/chipotle.jpg")
      starbucks = Business.create(name: "Starbucks", description: "Coffee shop.", image_url: "/tmp/starbucks.jpg")
      expect(Business.search_by_name("starbucks")).to eq([starbucks])
    end

    it "returns an array of all exact matches" do
      chipotle1 = Business.create(name: "Chipotle", description: "Mexican food.", image_url: "/tmp/chipotle.jpg")
      chipotle2 = Business.create(name: "Chipotle", description: "Mexican food.", image_url: "/tmp/chipotle.jpg")
      expect(Business.search_by_name("chipotle")).to match_array([chipotle1, chipotle2])
    end

    it "returns an array of one business for a partial match" do
      chipotle = Business.create(name: "Chipotle", description: "Mexican food.", image_url: "/tmp/chipotle.jpg")
      potluck = Business.create(name: "Potluck", description: "Made up shop.", image_url: "/tmp/starbucks.jpg")
      expect(Business.search_by_name("pot")).to match_array([chipotle, potluck])
    end

    it "returns an array of all matches ordered by created_at in reverse chronological order" do
      chipotle = Business.create(name: "Chipotle", description: "Mexican food.", image_url: "/tmp/chipotle.jpg")
      potluck = Business.create(name: "Potluck", description: "Made up shop.", image_url: "/tmp/starbucks.jpg")
      expect(Business.search_by_name("pot")).to eq([potluck, chipotle])
    end
  end
end