Rails.application.routes.draw do

  resources :casos
  resources :clientes do
    collection do
      get 'bajas'
    end
  end
  root "peticiones#new"
  resources :peticiones

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
