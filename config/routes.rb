Rails.application.routes.draw do
  root to: 'report#home'
  get 'relatorio', to: 'report#relatorio'
  get 'documento', to: 'report#documento'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
