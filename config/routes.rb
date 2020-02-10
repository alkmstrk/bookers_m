Rails.application.routes.draw do
  get 'search/index' => 'search#index', as: 'search'
  root 'home#top'
  get 'home/about' => 'home#about'

  get 'users/mail' => 'users#mail', as: 'mail'
  get 'rooms/users/:id' => "rooms#dm_create", as: 'dm_create'
  get 'rooms/:id' => 'rooms#show', as: 'room'

  devise_for :users

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show, :edit, :update]

  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

  get 'users/:id/following' => 'users#following', as: 'following'
  get 'users/:id/follow' => 'users#followers', as: 'followers'

  get 'users/:id/welcome' => 'users#welcome'
end
