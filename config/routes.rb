Rails.application.routes.draw do

  root "peticiones#index"

  resources :peticiones
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
