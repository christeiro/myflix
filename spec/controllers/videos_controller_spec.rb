require 'spec_helper'

describe VideosController do
  describe "GET #show" do
    it "sets the @video variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for autenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(video.reviews).to include(review1, review2)
    end

    it "redirects to the sign in page for unauthenticated users" do 
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end

  describe "POST #search" do
    it "sets the @videos variable if there is a match for authenicated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video, title: "futurama" )
      post :search, title: "futurama"
      expect(assigns(:videos)).to eq([video])
    end

    it "redirects to the sign in page for unauthenicated users" do
      video = Fabricate(:video, title: "futurama" )
      post :search, title: "futurama"
      expect(response).to redirect_to root_path
    end
  end
end