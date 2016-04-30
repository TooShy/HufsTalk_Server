Rails.application.routes.draw do
  root to: 'home#index'
  get '/privacy_security', to: 'home#privacy_security'
  mount API => '/api/client'
end
