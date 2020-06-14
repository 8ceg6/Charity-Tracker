Rails.application.routes.draw do
  root "session#index"
  resources :donations
  resources :donors
  resources :charities

  resources :donors do 
    resources :donations, only: [:new, :index, :show]
  end 
  # get '/' => 'donors#index'
  get '/login' => 'session#new'
  post '/login' => 'session#create'  
  get '/logout' => 'session#destroy'
 
  get 'auth/github/callback' => 'session#omni_create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
