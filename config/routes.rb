Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users

  root 'welcome#index'

  get 'dashboard' => 'dashboards#show'
  get 'pricing' => 'subscription#plans'
  post 'subscription_checkout' => 'subscription#subscription_checkout'
end
