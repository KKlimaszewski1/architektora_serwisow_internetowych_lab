Rails.application.routes.draw do
  


  resources :recipes do
    resources :comments
    collection do
      get :search
      end
    end
  root 'welcome#index'

  resources :users
  get 'signup', to: 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :accountactivations
  resources :password_resets

end