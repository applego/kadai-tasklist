Rails.application.routes.draw do
  # resources:tasks
  # Ajaxでデータを更新できるように、sort アクションを用意します。
  resources :tasks do
    put :sort
  end

  root to:'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #resources :sessions, only:[:new, :create, :destroy]
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index,:show,:create]
end
