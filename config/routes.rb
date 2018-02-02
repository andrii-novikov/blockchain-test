Rails.application.routes.draw do
  defaults format: :json do
    namespace :management do
      post :add_link
      post :add_transaction
      get :status
      get :state, action: 'status'
      get :sync
    end

    namespace :blockchain do
      post :receive_update
      get 'get_blocks/:count', to: :get_blocks, action: :get_blocks
    end
  end
end
