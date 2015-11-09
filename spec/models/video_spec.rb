require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }

  describe "#search_by_title" do
    it "returns one matching video" do
      video = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      expect(Video.search_by_title("man")).to eq(video)
    end

    it "returns more than one matching video" do
      antman = Video.create!(title: "Antman", description: "Antman movie from 2015")
      spiderman = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      expect(Video.search_by_title("man")).to include(antman, spiderman)
    end

    it "does not find any matching videos" do
      video = Video.create!(title: "Spiderman", description: "Spiderman movie from 2000")
      expect(Video.search_by_title("Southpark")).to be_empty
    end
  end
end