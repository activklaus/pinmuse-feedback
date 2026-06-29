Rails.application.routes.draw do
  resources :feedbacks, only: [:create, :index]
  get '/health', to: proc { [200, {}, ['ok']] }
end
