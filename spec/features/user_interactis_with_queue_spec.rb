# Login
# Go to video
# Press Button My Queue
# Go to My Queue Page
# Make Sure the Video is there
# If the video is there, follow the link
# Check if it's the correct video you just added
# The My Queue button is not visible anymore

# Go to the  home page again
# Add Couple more videos to my queue
# Go to my queue and re-order the videos
# Update queue
# Verify they come back in a correct order

require 'spec_helper'

feature "User interactis with the queue" do
  scenario "user adds and reoders videos in the queue" do
    
    category = Fabricate(:category)
    monk = Fabricate(:video, category: category)
    south_park = Fabricate(:video, category: category)
    futurama = Fabricate(:video, category: category)

    sign_in
    # binding.pry

    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_not_to_be_seen("+ My Queue")

    add_video_to_queue(south_park)
    add_video_to_queue(futurama)
    
    set_video_position(south_park, 1)
    set_video_position(futurama, 2)
    set_video_position(monk, 3)

    update_queue
    
    expect_video_position(south_park, 1)
    expect_video_position(futurama, 2)
    expect_video_position(monk, 3)

  end
  scenario "Add video to the queue" do
    alice = Fabricate(:user)
    visit(sign_in_path)
    fill_in "email", with: alice.email
    fill_in "password", with: alice.password
    click_button('Sign in')
    category = Fabricate(:category)
    south_park = Fabricate(:video, title: "Futurama", category: category)
    visit home_path
    click_link "video_#{south_park.id}"
    click_link "+ My Queue"
    expect(page).to have_content south_park.title
  end

  def update_queue
    click_button "Update Instant Queue"
  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content video.title
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).not_to have_content link_text
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def expect_video_position(video,position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end
end
