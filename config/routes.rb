Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :calendars, except: [:edit, :update, :destroy] do
    resources :events, only: [:new, :create, :edit, :update]
  end
  root to: 'welcome#show'
end
