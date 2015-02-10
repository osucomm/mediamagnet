Rails.application.routes.draw do

  get 'dashboard' => 'dashboard#show', as: :dashboard

  # OAuth
  get 'auth/google/choose' => 'google#choose'
  get 'auth/google_oauth2/callback' => 'google#callback'
  get 'auth/facebook/callback' => 'tokens#create'

  # Omniauth and sessions
  get 'auth/failure', to: 'sessions#failure'
  get 'auth/:provider', to: lambda{|env| [404, {}, ["Not Found"]]}, as: 'auth'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  delete 'logout', to: 'sessions#destroy', as: 'logout'


  resources 'tokens', only: [:index, :destroy]
  resources :keywords
  resources :links
  resources :categories, only: [:index]
  resources :keywordings, only: [:new, :create, :destroy]

  #reports
  get 'reports/keyword_usage'

  Mapping::TYPES.each do |type|
    resources type.model_name.plural, only: [:new, :create, :destroy], controller: 'mappings', type: type.to_s
  end

  resources :items, only: [:index, :show]

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :entities, only: [:index, :update]
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
