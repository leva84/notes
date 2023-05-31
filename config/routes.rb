Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  root to: 'notes#index'

  resources :notes, only: %i[index create destroy]
end
