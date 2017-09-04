Rails.application.routes.draw do

  root "pages#home"
  get "pages/home", to: 'pages#home'
  get '/help', to: 'pages#help'
  get '/contact', to: 'pages#contact'
  get '/terms', to: 'pages#terms'
  get '/privacy', to: 'pages#privacy'
  get '/about', to: 'pages#about'
  get '/starting', to: 'pages#starting'
  get '/cookie', to: 'pages#cookie'

  get '/comments_with_button', to: 'article#comments_with_button', as: 'comments_with_button'

  resources :articles do
    resources :comments, only: [:create, :destroy]
  end

  get '/signup', to: 'users#new'


  get '/users/pass/:id', to: 'users#pass', :as => 'edit_user_pass'
  resources :users do
    member do
      get :following, :followers
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :relationships, only: [:create, :destroy]

  mount ActionCable.server => '/cable'
  mount Ckeditor::Engine => '/ckeditor'
end
