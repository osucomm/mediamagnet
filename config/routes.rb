Rails.application.routes.draw do
  devise_for :users
  get 'dashboard' => 'dashboard#show'

  resources :keywords, only: [:index, :show]
  resources :entities
  resources :channels

  Channel::TYPES.each do |type|
    resources type.constantize.model_name.plural, controller: 'channels', type: type
  end

  root 'welcome#show'
end
