Rails.application.routes.draw do
  resources :static_pages

  root to: "static_pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/search', to: 'static_pages#search', via: :get
end
