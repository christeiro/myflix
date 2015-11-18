require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items) }

  describe "#search_by_title" do
    it "return an empty array if there is no match" do
      spiderman = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      southpark = Video.create!(title: "Southpark", description: "Southpark movie from 1999")
      expect(Video.search_by_title("hello")).to be_empty
    end

    it "returns an array of one video for exact match" do
      spiderman = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      southpark = Video.create!(title: "Southpark", description: "Southpark movie from 1999")
      expect(Video.search_by_title("Spiderman")).to eq([spiderman])
    end

    it "returns an arry of one video for partial match" do
      spiderman = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      southpark = Video.create!(title: "Southpark", description: "Southpark movie from 1999")
      expect(Video.search_by_title("Spider")).to eq([spiderman])
    end

    it "returns an array of all matches ordered by created_at" do  
      antman = Video.create!(title: "Antman", description: "Antman movie from 2015", created_at: 1.day.ago)
      spiderman = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      expect(Video.search_by_title("man")).to eq([spiderman, antman])
    end

    it "returns an empty array for a search with an empty string" do
      spiderman = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      southpark = Video.create!(title: "Southpark", description: "Southpark movie from 1999")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end