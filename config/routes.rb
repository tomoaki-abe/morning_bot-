Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts, only: [:index] do
    collection do
      get 'project'
      get 'start'
      get 'mypage'
    end
  end

  get 'webhook/kokodayo'
  post '/callback' => 'linebot#callback'
end