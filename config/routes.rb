Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :calendars do
    resources :events, except: [:index, :show]
  end
  root to: 'welcome#show'
end
