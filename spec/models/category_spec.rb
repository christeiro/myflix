require 'spec_helper'

describe Category do
  it "save Category record" do
    category = Category.new(name: "Cartoons")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    category = Category.create(name: "Cartoons")
    spiderman = Video.create(title: "Spiderman", description: "Spiderman cartoon from 2000", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg", category: category)
    ironman = Video.create(title: "Ironman", description: "Ironman cartoon from 2005", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg", category: category)
    expect(category.videos).to include(spiderman, ironman)
  end
end