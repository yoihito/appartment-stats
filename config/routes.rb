Rails.application.routes.draw do
  resource :apartments, only: [:index]
  root 'apartments#index'
end
