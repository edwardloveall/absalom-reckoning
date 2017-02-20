Rails.application.routes.draw do
  resources :calendars, only: [:index]
  root to: 'calendars#index'
end
