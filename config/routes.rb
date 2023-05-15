Rails.application.routes.draw do
  get 'users/edit'
  get 'users/show'
  devise_for :users
  root to: "home#index"
  resources :users
  get 'home/show'



end
