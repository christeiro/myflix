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

  it "does not save without title" do
    video = Video.create(description: "Spiderman cartoon from 2000")
    expect(Video.count).to eq(0)
  end

  it "does not save without description" do
    video = Video.create(title: "Spiderman")
    expect(Video.count).to eq(0)
  end
end