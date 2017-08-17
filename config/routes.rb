Rails.application.routes.draw do
  root "pages#home"
  get "pages/home", to: 'pages#home'
  get '/help', to: 'pages#help'
  get '/contact', to: 'pages#contact'
  get '/terms', to: 'pages#terms'
  get '/privacy', to: 'pages#privacy'
  get '/about', to: 'pages#about'
  get '/starting', to: 'pages#starting'

  resources :recipes
  get '/signup', to: 'users#new'
  resources :users, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
