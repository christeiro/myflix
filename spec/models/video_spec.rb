require 'spec_helper'

describe Video do
  it "save Video record" do
    video = Video.new(title: "Spiderman", description: "Spiderman cartoon from 2000", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg")
    video.save
    expect(Video.first).to eq(video) # The expect syntax is what the Rspec core team favors nowadays
  end

  it "has category" do
    category = Category.create(name: "Cartoons")
    video = Video.create(title: "Spiderman", description: "Spiderman cartoon from 2000", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg", category: category)
    expect(video.category).to eq(category)
  end

  it "title is required" do
    video = Video.new(description: "Spiderman cartoon from 2000")
    video.valid?
    expect(video.errors[:title].size).to eq(1)
  end

  it "description is required" do
    video = Video.new(title: "Spiderman")
    video.valid?
    expect(video.errors[:description].size).to eq(1)
  end

  it "title and description is required" do
    video = Video.new()
    video.valid?
    expect(video.errors.messages).to include(:title, :description)
  end
end