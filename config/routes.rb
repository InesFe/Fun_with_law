Rails.application.routes.draw do
  resources :decisions
  root "home#page"
  get "home/level", to: "home#level"
end
