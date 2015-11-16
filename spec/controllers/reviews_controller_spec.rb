require 'spec_helper'

describe ReviewsController do
  describe "POST #create" do
    context "with valid input" do
      it "sets the @review variable for authenticated user" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video);
        user = Fabricate(:user);
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review), user: user
        expect(video.reviews.count).to eq(1)
      end
      it "shows the success message for authenticated user" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video);
        user = Fabricate(:user);
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review), user: user
        expect(flash[:notice]).not_to be_blank
      end
      it "redirects to the video page for authenticated user" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video);
        user = Fabricate(:user);
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review), user: user
        expect(response).to redirect_to video_path(video)
      end
      it "redirects to the sign in page for unauthenticated user" do
        video = Fabricate(:video);
        user = Fabricate(:user);
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid input" do
      it "does not create the review for authenticated user" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video);
        user = Fabricate(:user);
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review, description: ''), user: user
        expect(video.reviews.count).to eq(0)
      end
      it "redirects back to the video page for authenicated user" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video);
        user = Fabricate(:user);
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review, description: ''), user: user
        expect(response).to redirect_to video_path(video)
      end
      it "redirects to the sign in page for unauthenticated user" do
        video = Fabricate(:video);
        user = Fabricate(:user);
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review, description: '')
        expect(response).to redirect_to root_path
      end
    end
  end
end