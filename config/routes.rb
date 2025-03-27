Rails.application.routes.draw do
  resources :decisions
  root "home#page"
  get "home/level", to: "home#level"
  get "jeu/index", to: "jeu#index"
  post "/jeu/submit", to: "jeu#submit"
end
