Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :invitations, only: [:index]
  resources :permissions, only: [:create]
  resources :calendars do
    resources :events, except: [:index, :show]
    resources :invitations, only: [:create, :destroy]
  end
  root to: 'welcome#show'
end
