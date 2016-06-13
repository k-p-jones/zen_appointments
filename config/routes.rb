Rails.application.routes.draw do
  root "home#index"
  get "home/index"
  get "home/day_view"
  resources :events
end
