Rails.application.routes.draw do
  
  # resources:tasks
  # Ajaxでデータを更新できるように、sort アクションを用意します。
  resources :tasks do
    put :sort
  end

  root to:'tasks#index'
end
