Rails.application.routes.draw do
  resources :presents

  resources :guests
  patch '/guests/enqueue' => 'guests#enqueue', as: 'guests_enqueue'

  get '/impressum' => 'application#imprint', as: 'imprint'
end
