Rails.application.routes.draw do
  devise_for :admins
  devise_for :guests
  root 'application#root'

  resources :presents

  # API

  namespace :api, defaults: { format: 'json' } do
    get '/' => redirect('/api/v1')

    namespace :v1 do
      get '/' => redirect('/api/v1/guest_list')
      get '/guest_list' => 'guest_list#show'
    end
  end

  get '/guests/prepare_email' => 'guests#prepare_email', as: 'guests_prepare_email'
  patch '/guests/send_emails' => 'guests#send_emails', as: 'guests_send_emails'
  patch '/guests/enqueue' => 'guests#enqueue', as: 'guests_enqueue'
  resources :guests

  get '/impressum' => 'application#imprint', as: 'imprint'
end
