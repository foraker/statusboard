Rails.application.routes.draw do
  get 'static_pages/index'
  root 'static_pages#index'

  resources :tweets

  namespace :api do
    resources :bathroom_updates
  end
end
