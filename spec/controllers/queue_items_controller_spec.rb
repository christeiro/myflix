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
      it "orders the @queue_items by order_id ASC" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, video: video1, order_id: 2, user: user)
        queue_item2 = Fabricate(:queue_item, video: video1, order_id: 1, user: user)
        get :index
        expect(assigns(:queue_items)).to start_with([queue_item2,queue_item1])
      end
    end
    context "with unauthenticated user" do
      it "redirects to the root_path" do
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST create" do
    it "should redirect to root_path for unauthenticated user" do
      post :create
      expect(response).to redirect_to root_path
    end
    it "should redirect to my_queue path for authenticated user" do
      session[:user_id] = Fabricate(:user)
      post :create
      expect(response).to redirect_to my_queue_path
    end
    it "should add a video to queue_items" do
      session[:user_id] = Fabricate(:user)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
  end
end