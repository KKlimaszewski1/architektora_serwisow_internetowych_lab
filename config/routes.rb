Rails.application.routes.draw do
 
  resources :recipes
 
  root 'welcome#index'
end