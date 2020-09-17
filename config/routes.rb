Rails.application.routes.draw do
  get 'webhook/kokodayo'
  post '/callback' => 'linebot#callback'
end