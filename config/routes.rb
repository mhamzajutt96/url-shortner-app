Rails.application.routes.draw do
  resources :links
  get '/s/:slug', to: 'links#show', as: :short
end
