Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :calendars do
    resources :events, only: [:new, :create, :edit, :update]
  end
  root to: 'welcome#show'
end
