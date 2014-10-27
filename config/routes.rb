Rails.application.routes.draw do
  devise_for :users
  get 'dashboard' => 'dashboard#show'

  resources :keywords, only: [:index, :show]
  resources :entities
  resources :channels
  resources :twitter_channels, controller: 'channels', type: 'Twitter'
  resources :instagram_channels, controller: 'channels', type: 'Instagram'
  resources :web_channels, controller: 'channels', type: 'Web'
  resources :event_channels, controller: 'channels', type: 'Event'
  resources :facebook_channels, controller: 'channels', type: 'Facebook'
  resources :youtube_channels, controller: 'channels', type: 'Youtube'

  root 'welcome#show'
end
