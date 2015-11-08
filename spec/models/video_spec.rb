require 'spec_helper'

describe Video do
  it "save Video record" do
    video = Video.new(title: "Spiderman", description: "Spiderman cartoon from 2000", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg")
    video.save
    expect(Video.first).to eq(video) # The expect syntax is what the Rspec core team favors nowadays
  end

  it "save Video with category" do
    category = Category.first
    video = Video.new(title: "Spiderman", description: "Spiderman cartoon from 2000", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg", category: category)
    video.save
    expect(video.reload.category).to eq(category)
  end
end