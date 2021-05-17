Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/hello', to: 'home#hello'
  


  resources :posts do
    collection do
      get '/non_published', to: 'posts#non_published'
    end
    
    resources :comments
  end

  #get '/posts/non_published', to: 'posts#non_published'

  root to: redirect('/posts')

end
