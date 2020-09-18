Rails.application.routes.draw do
  root to: 'posts#index'
  get 'webhook/kokodayo'
  post '/callback' => 'linebot#callback'

  resources :posts, only: [:index] do
    collection do
      get 'project'
      get 'start'
      get 'mypage'
      get 'detailed'
    end
  end
  
end