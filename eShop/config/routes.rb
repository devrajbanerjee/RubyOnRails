Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get 'products' => 'products#index'
  #get 'products/new' => 'products#new'
  resources :sessions, only: [:create, :destroy]
  
  resources :users, except: [:index, :destroy]
  
  resources :products do
	member do
		get :checkout
		patch :buy
	end	
  end
end
