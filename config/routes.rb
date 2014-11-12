Rails.application.routes.draw do


  devise_for :users, path: 'user', :skip => [:registrations] 
  as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
        put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  get 'dashboard' => 'dashboard#show', as: :dashboard

  resources :keywords
  resources :items, only: [:index, :show]
  resources :users, only: [:index, :update]

  resources :channels, only: [:index, :show, :destroy] do
    resources :items, only: [:index, :show]
  end

  Channel::TYPES.each do |type|
    resources type.model_name.plural, only: :index, controller: 'channels', type: type.to_s
  end

  resources :entities, shallow: true do
    resources :channels, only: [:index, :show]

    Channel::TYPES.each do |type|
      resources type.model_name.plural, controller: 'channels', type: type.to_s
    end
  end

  root 'welcome#show'
end
