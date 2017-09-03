Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'satatic_pages#home'

  get '/help', :to => 'satatic_pages#help'
  get '/about', :to => 'satatic_pages#about'
  get '/contact', :to => 'satatic_pages#contact'
end
