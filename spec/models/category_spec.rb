require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  describe "#recent_videos" do
    it "returns the videos in the reverse chronical order by created at" do
      category = Category.create(name: "Cartoons")
      batman = Video.create(title: "Batman", description: "The batman movie", category: category)
      spiderman = Video.create(title: "Spiderman", description: "The spiderman movie", created_at: 1.day.ago, category: category)
      expect(category.recent_videos).to eq([batman, spiderman])
    end

    it "returns all videos from category if there's less than 6 videos" do
      category = Category.create(name: "Cartoons")
      batman = Video.create(title: "Batman", description: "The batman movie", category: category)
      spiderman = Video.create(title: "Spiderman", description: "The spiderman movie", created_at: 1.day.ago, category: category)
      antman = Video.create(title: "Antman", description: "The antman movie", created_at: 2.days.ago, category: category)
      expect(category.recent_videos.count).to eq(3)
    end

    it "returns 6 videos from category if there's more than 6 videos" do
      category = Category.create(name: "Cartoons")
      7.times {Video.create(title: "foo", description: 'bar', category: category)}
      expect(category.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      category = Category.create(name: "Cartoons")
      6.times {Video.create(title: "foo", description: 'bar', category: category)}
      spiderman = Video.create(title: "Spiderman", description: "The spiderman movie", created_at: 1.day.ago, category: category)
      expect(category.recent_videos).not_to include(spiderman)
    end

    it "returns an empty array of the category does not have any videos" do
      category = Category.create(name: "Cartoons")
      expect(category.recent_videos).to eq([])
    end
  end
end