Rails.application.routes.draw do
  resources :usuario_externos do
    member do
      get :confirm_email
    end
  end

  resources :replegales
  resources :casos
  resources :clientes do
    collection do
      get 'bajas'
      get 'contabilidad'
      post 'contabilidad', to: 'clientes#post_contabilidad'
    end
    resources :obligaciones, except: :show
  end
  root "peticiones#new"
  resources :peticiones

  post '/login', to:'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auditoria', to:'auditoria#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
