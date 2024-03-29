Rails.application.routes.draw do
  resources :password_resets, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create] do
    resources :password_resets, only: [:edit, :update]
  end
  resources :invitations, only: [:index]
  resources :permissions, only: [:create]
  resources :calendars do
    member do
      patch 'current_date'
    end
    resources :events, except: [:index, :show]
    resources :invitations, only: [:create, :destroy]
    resources :permissions, only: [:destroy]
  end
  match '/404', to: 'errors#not_found', via: :all, as: :not_found
  match '/500', to: 'errors#internal_server_error', via: :all, as: :internal_server_error
  root to: 'welcome#show'
end
