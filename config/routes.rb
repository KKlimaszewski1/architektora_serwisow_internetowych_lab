Rails.application.routes.draw do
  
  resources :recipes do
    resources :comments
    end
  root 'welcome#index'

  resources :users
  get 'signup', to: 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :accountactivations

end