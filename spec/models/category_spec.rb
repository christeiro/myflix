require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  describe "#recent_videos" do
    it "returns all videos from category if there's less than 6 videos in category ordered by created_at desc" do
      category = Category.create(name: "Cartoons")
      batman = Video.create(title: "Batman", description: "The batman movie", category: category)
      spiderman = Video.create(title: "Spiderman", description: "The spiderman movie", created_at: 1.day.ago, category: category)
      antman = Video.create(title: "Antman", description: "The antman movie", created_at: 2.days.ago, category: category)
      expect(category.recent_videos).to eq([batman, spiderman, antman])
    end

    it "returns 6 videos from category if there's more than 6 videos in category ordered by created_at desc" do
      category = Category.create(name: "Cartoons")
      batman = Video.create(title: "Batman", description: "The batman movie", category: category)
      spiderman = Video.create(title: "Spiderman", description: "The spiderman movie", created_at: 1.day.ago, category: category)
      antman = Video.create(title: "Antman", description: "The antman movie", created_at: 2.days.ago, category: category)
      southpark = Video.create(title: "Southpark", description: "The southpark movie", created_at: 3.days.ago, category: category)
      futurama = Video.create(title: "Futurama", description: "The Futurama movie", created_at: 4.days.ago, category: category)
      toystory = Video.create(title: "Toy Story", description: "The Toy Story movie", created_at: 5.days.ago, category: category)
      up = Video.create(title: "Up", description: "The up movie", created_at: 6.days.ago, category: category)
      shrek = Video.create(title: "Shrek", description: "The shrek movie", created_at: 7.days.ago, category: category)
      expect(category.recent_videos).to eq([batman,spiderman,antman,southpark, futurama,toystory])
    end

    it "does not return a category if there's no video" do
    end
  end
end