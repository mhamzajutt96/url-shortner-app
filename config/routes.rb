Rails.application.routes.draw do
  Rails.application.routes.default_url_options[:host] = 'http://localhost:3000/'
  resources :links, except: %i[show edit update]
  get '/s/:slug', to: 'links#show', as: :short
end
