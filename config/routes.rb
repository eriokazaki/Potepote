Rails.application.routes.draw do
  get 'reservations/index'
  get 'users/sogn_out' => 'devise/sessions#destroy'
  resources :rooms
  devise_for :users

  root to: "home#index"
  
  get 'home/show'
  
  post 'users/:id/edit' => 'users#show'
  get '/mypage' => 'users#mypage'
  resources :users, only: [:show, :edit, :update]
  # 検索のために必要
  resources :rooms do
    collection do
      get 'search'
    end
  end

  resources :reservations do
    collection do
      post 'confirm'
    end
  end
  resources :reservations
  post 'reservations/:id' => 'reservations#index'
end
