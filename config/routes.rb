RackAcademy::Application.routes.draw do
  root :to => 'pages#index'

  resources :lessons do
  end
end
