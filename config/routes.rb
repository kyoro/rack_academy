RackAcademy::Application.routes.draw do
  root :to => 'lessons#index'

  resources :lessons do
    get :chapters
  end
end
