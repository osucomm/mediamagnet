Rails.application.routes.draw do


  devise_for :users, path: 'user', :skip => [:registrations] 
  as :user do
    get 'user/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'user' => 'devise/registrations#update', :as => 'user_registration'
  end

  get 'dashboard' => 'dashboard#show', as: :dashboard

  resources :keywords
  resources :items, only: [:index, :show]
  resources :users, only: [:index, :update]

  resources :channels, except: [:new, :create] do
    resources :items, only: [:index, :show]
  end

  Channel::TYPES.each do |type|
    resources type.model_name.plural, except: [:new, :create], controller: 'channels', path: 'channels', type: type.to_s
  end

  resources :entities do
    resources :channels, only: [:index]

    Channel::TYPES.each do |type|
      resources type.model_name.plural, only: [:new, :create], controller: 'channels', type: type.to_s
    end
  end

  root 'welcome#show'
end
