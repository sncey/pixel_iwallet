Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  resources :users, only: [:index, :show, :edit, :update]
  resources :albums, only: [:index]
  root 'users#index'
  get '/fetch_albums_and_photos', to: 'albums#fetch_albums_and_photos'
  match '*path', to: 'errors#not_found', via: :all
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  # Defines the root path route ("/")
  # root "posts#index"
end
