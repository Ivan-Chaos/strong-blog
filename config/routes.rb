Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/hello', to: 'home#hello'
  


  resources :posts do
    resources :comments
  end
  root to: redirect('/posts')


end
