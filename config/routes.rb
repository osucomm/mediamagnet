Rails.application.routes.draw do



  namespace :admin do
  get 'delayed_jobs/index'
  end

  devise_for :users, :skip => [:registrations], :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  as :user do
    get 'user/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'user' => 'devise/registrations#update', :as => 'user_registration'
  end

  get 'dashboard' => 'dashboard#show', as: :dashboard
  get 'users/auth/google/choose' => 'google#choose'
  get 'users/auth/google_oauth2/callback' => 'google#callback'
  get 'users/auth/facebook/callback' => 'tokens#create'
  get 'tokens' => 'tokens#index'

  resources :keywords
  resources :links

  #reports
  get 'reports/keyword_usage'

  Mapping::TYPES.each do |type|
    resources type.model_name.plural, only: [:new, :create, :destroy], controller: 'mappings', type: type.to_s
  end

  resources :items, only: [:index, :show]

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :delayed_jobs, only: [:index, :destroy]
  end

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


  # Help
  get 'help'                  => 'help#index', as: :help
  get 'help/:category'        => 'help#category',  as: :help_category
  get 'help/:category/:file'  => 'help#show',  as: :help_page

  root 'welcome#show'
end
