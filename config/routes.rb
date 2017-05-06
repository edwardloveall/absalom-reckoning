Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :calendars, only: [:show]
  root to: 'welcome#show'
end
