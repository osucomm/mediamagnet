Rails.application.routes.draw do
  resources :keywords

  root 'welcome#show'
end
