require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated user" do
      it "renders the index template" do
        session[:user_id] = Fabricate(:user).id
        get :index
        expect(response).to render_template :index
      end
      it "sets the @queue_items variable" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: user)
        get :index
        expect(assigns(:queue_items)).to eq([queue_item])
      end
    end
    context "with unauthenticated user" do
      it "redirects to the root_path" do
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end
end