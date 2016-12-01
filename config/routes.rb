Rails.application.routes.draw do

  namespace :marvel do
    root 'characters#index'
    resources :characters, only:[:index, :show]
  end

  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/characters", to: 'characters#index'
      get "/characters/:marvel_id", to: "characters#show"
    end
  end

end
