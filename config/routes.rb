Rails.application.routes.draw do
  devise_for :admins
  devise_for :guests
  root 'application#root'

  resources :presents

  get '/guests/prepare_email' => 'guests#prepare_email', as: 'guests_prepare_email'
  patch '/guests/send_emails' => 'guests#send_emails', as: 'guests_send_emails'
  patch '/guests/enqueue' => 'guests#enqueue', as: 'guests_enqueue'
  resources :guests

  get '/impressum' => 'application#imprint', as: 'imprint'
end
