Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :users, only:[:edit, :update]
  resources :groups,except:[:destroy] do
    resources :messages, only: :index
  end
end
