Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	resources :posts do
  		resources :comments
	end

  	root 'posts#index'

	get '/user_profile/:id', to: 'posts#user_profile', as: 'user_profile'
end
