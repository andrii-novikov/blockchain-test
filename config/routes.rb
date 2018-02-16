Rails.application.routes.draw do
  root 'home#index'
  resource :home

  namespace :management, format: :json do
    post :add_link
    post :add_transaction
    get :status
    get :state, action: 'status'
    get :sync
    get :all_status
  end

  namespace :blockchain, format: :json do
    post :receive_update
    get 'get_blocks/:count', to: :get_blocks, action: :get_blocks
  end
end
