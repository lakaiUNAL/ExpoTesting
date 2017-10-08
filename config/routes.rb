Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'satatic_pages#home'

  get '/help', :to => 'satatic_pages#help'
  get '/about', :to => 'satatic_pages#about'
  get '/contact', :to => 'satatic_pages#contact'
  
  get '/singup', to: 'users#new'
  post '/singup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
end
