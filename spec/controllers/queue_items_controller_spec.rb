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
        queue_item1 = Fabricate(:queue_item, video: video1, user: user)
        queue_item2 = Fabricate(:queue_item, video: video1, user: user)
        get :index
        expect(assigns(:queue_items)).to start_with([queue_item1,queue_item2])
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
    it "redirects to root_path for unauthenticated user" do
      post :create
      expect(response).to redirect_to root_path
    end 
    it "redirects to my_queue path for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates the queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to be(1)
    end
    it "creates the queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates the queue item that is associated with the sign in user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(user)
    end
    it "puts the video as last one in the queue" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      monk = Fabricate(:video, title: "Monk")
      Fabricate(:queue_item, video: monk, user: user)
      futurama = Fabricate(:video, title: "Futurama")
      post :create, video_id: futurama.id
      futurama_queue_item = QueueItem.where(video_id: futurama.id, user_id: user.id).first
      expect(futurama_queue_item.position).to eq(2)
    end
    it "does not add the video to the queue if the video is already in the queue" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      monk = Fabricate(:video, title: "Monk")
      Fabricate(:queue_item, video: monk)
      post :create, video_id: monk.id
      expect(user.queue_items.count).to eq(1)
    end
  end
end