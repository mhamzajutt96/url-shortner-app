Rails.application.routes.draw do
  root 'links#index'
  resources :links, except: %i[show edit update]
  get '/:short_url', to: 'links#show'
  get 'shortened/:short_url', to: 'links#shortened', as: :shortened
  get 'links/fetch_original_url'
end
