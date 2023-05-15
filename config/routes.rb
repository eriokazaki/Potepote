Rails.application.routes.draw do
  resources :rooms
  devise_for :users
  get 'users/show'
  root to: "home#index"
  resources :users
  get 'home/show'
  
  post 'users/:id/edit' => 'users#show'
  get '/mypage' => 'users#mypage'

end
