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
  resources :memberships, only: [:new, :create, :destroy]
  delete 'memberships/destroy', to: 'memberships#destroy'

  #reports
  get 'reports/keyword_usage'

  Mapping::TYPES.each do |type|
    resources type.model_name.plural, only: [:new, :create, :destroy], controller: 'mappings', type: type.to_s
  end

  resources :items, only: [:index, :show, :destroy]

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :entities, only: [:index, :update]
    resources :delayed_jobs, only: [:index, :destroy]
    get 'flush_refresh_queue', to: 'delayed_jobs#flush_refresh_queue'
  end

  get 'channels/:id/refresh' => 'channels#refresh'

  resources :channels, except: [:new, :create] do
    #resources :items, only: [:index, :show]
  end

  Channel::TYPES.each do |type|
    resources type.model_name.plural, except: [:new, :create], controller: 'channels', path: 'channels', type: type.to_s
  end

  resources :entities do
    resources :channels, only: [:index]

    Channel::TYPES.each do |type|
      resources type.model_name.plural, only: [:new, :create, :update], controller: 'channels', type: type.to_s
    end
  end


  #API
  namespace :api, defaults: { format: :json }, constraints: { format: /(json|xml|rss)/ } do
    api_version(:module => "v1",
      :path => {:value => "v1"},
      :default => true) do

      resources :items, only: [:index, :show]
      resources :keywords, only: [:index, :show]
      resources :channels, only: [:index, :show]
      resources :entities, only: [:index, :show]
      resources :events, only: [:index, :show]
    end
  end


  # Help
  get 'help'                  => 'help#index', as: :help
  get 'help/:category'        => 'help#category',  as: :help_category
  get 'help/:category/:file'  => 'help#show',  as: :help_page


  # Errors
  %w( 400 403 404 422 500 503 ).each do |status|
    get status, :to => "errors#show", :status => status
  end

  root 'welcome#show'
end
