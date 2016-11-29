Rails.application.routes.draw do

  namespace :marvel do
    root 'characters#index'
    resources :characters, only:[:index, :show]
  end

  namespace :api, defaults: { format: :json } do
    get "/characters",    to: "characters#index"

    get "/character/:id", to: "characters#show"
  end

end
