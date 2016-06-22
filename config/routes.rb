Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "home/index"
  get "home/day_view"
  resources :events
  resources :options
end
