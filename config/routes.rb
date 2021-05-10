Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/hello', to: 'home#hello'
  
  get '/posts', to: 'posts#index'
  post '/posts', to: 'posts#create'
  get '/posts/new', to: 'posts#new', as: :new_post
  get '/posts/:id', to: 'posts#show', as: :post
  get '/posts/:id/edit', to: 'posts#edit', as: :edit_post
  patch '/posts/:id', to: 'posts#update'
  delete '/posts/:id', to: 'posts#destroy'

  resources :posts do
    resources :comments
  end
  root to: redirect('/posts')


end
