Rails.application.routes.draw do
  root to: 'report#home'
  get 'relatorio', to: 'report#relatorio'
  get 'documento', to: 'report#documento'
  get 'orgao/:id', to: 'report#orgao'
  get 'servico/:id', to: 'report#servico'
  get 'rascunho', to: 'report#rascunho'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
