Rails.application.routes.draw do
  resources :rooms
  devise_for :users
  root to: "home#index"
  resources :users
  get 'home/show'

  get '/mypage' => 'users#mypage'
  post 'users/:id/edit' => 'users#show'

end
