Rails.application.routes.draw do
  get 'reservations/index'
  resources :rooms
  devise_for :users
  get 'users/show'
  root to: "home#index"
  resources :users
  get 'home/show'
  
  post 'users/:id/edit' => 'users#show'
  get '/mypage' => 'users#mypage'

  resources :reservations do
    collection do
      post 'confirm'
    end
  end
  resources :reservations
  post 'reservations/:id' => 'reservations#index'
end
