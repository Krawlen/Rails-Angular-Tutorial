Rails.application.routes.draw do
  get 'recipes/index'
  root 'home#index'

  resources :recipes, only: [:index, :show]

end
