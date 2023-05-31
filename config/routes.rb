Rails.application.routes.draw do
  devise_for :users

  root to: 'notes#index'

  resources :notes, only: %i[index create destroy]
end
