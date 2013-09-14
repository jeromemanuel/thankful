Thankful::Application.routes.draw do
  
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  get '/:id/user' => 'notes#user_profile', as: :user_profile
  
  root :to => 'notes#index'
  resources :notes do
    member { post :vote }
  end

  get '/about' => 'notes#about', as: :about


end
