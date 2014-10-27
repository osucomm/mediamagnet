Rails.application.routes.draw do
  get 'entities/index'

  get 'entities/show'

  get 'entities/new'

  get 'entities/create'

  get 'entities/edit'

  get 'entities/update'

  get 'entities/destroy'

  devise_for :users
  get 'dashboard' => 'dashboard#show'

  resources :keywords

  root 'welcome#show'
end
