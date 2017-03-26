Rails.application.routes.draw do
  devise_for :admins
  resources :forms, only: [:new, :create, :index, :show, :destroy] do
    get "submitted", on: :collection
  end
  root to: "forms#new"
end
