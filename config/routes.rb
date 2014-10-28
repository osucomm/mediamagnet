Rails.application.routes.draw do
  devise_for :users
  get 'dashboard' => 'dashboard#show'

  resources :keywords, only: [:index, :show]
  resources :channels, only: [:index, :show, :destroy]

  resources :entities, shallow: true do
    Channel::TYPES.each do |type|
      resources type.model_name.plural, controller: 'channels', type: type.to_s
    end
  end

  root 'welcome#show'
end
