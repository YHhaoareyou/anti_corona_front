Rails.application.routes.draw do
  get 'users/:id', to: 'users#show'
  post 'posts/close/:id', to: 'posts#close'
  post 'posts/reopen/:id', to: 'posts#reopen'
  resources :posts
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
