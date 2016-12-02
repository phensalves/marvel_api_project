Rails.application.routes.draw do

  devise_for :users
  get "/", to: "marvel/characters#index", as: "root"
  
  namespace :marvel do
    resources :characters, only:[:index, :show]
  end

  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get     "/characters",                  to: 'characters#index'
      get     "/characters/:marvel_id",       to: 'characters#show'
      post    "/characters/new",              to: 'characters#create'
      put     "/characters/:marvel_id/edit",  to: 'characters#update'
      delete  "/characters/:marvel_id/delete",to: 'characters#destroy'
    end
  end

end
