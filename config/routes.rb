Rails.application.routes.draw do
  root to: 'home#index'
  mount API => '/api/client'
end
