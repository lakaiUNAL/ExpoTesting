Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'satatic_pages/home'
  get 'satatic_pages/help'
  get 'satatic_pages/about'
  root 'satatic_pages#home'
end
