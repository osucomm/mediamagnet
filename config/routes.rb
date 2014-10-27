Rails.application.routes.draw do
  devise_for :users
  get 'dashboard' => 'dashboard#show'

  resources :keywords, only: [:index, :show]
  resources :entities

  root 'welcome#show'
end
