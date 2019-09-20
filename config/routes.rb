Rails.application.routes.draw do
  root 'home#top'
  get 'home/about' => 'home#about'

  # デバイスのルートを上に書く
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  resources :books, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
