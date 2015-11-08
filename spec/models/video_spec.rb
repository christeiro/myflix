require 'spec_helper'

describe Video do
  it "save Video record" do
    video = Video.new(title: "Spiderman", description: "Spiderman cartoon from 2000", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/mong.jpg")
    video.save
    Video.first.title.should == "Spiderman"
  end
end