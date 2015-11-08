require 'spec_helper'

describe Category do
  it "save Category record" do
    category = Category.new(name: "Cartoons")
    category.save
    expect(Category.first).to eq(category)
  end

  it "have many videos" do
    category = Category.create!(name: "Cartoons")
    video1 = category.videos.create!(title: "Spiderman", description: "Spiderman cartoon from 2000", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg")
    video2 = category.videos.create!(title: "Ironman", description: "Ironman cartoon from 2005", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg")
    expect(category.reload.videos).to eq([video2, video1])
  end
end