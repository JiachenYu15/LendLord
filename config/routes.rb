Rails.application.routes.draw do

	root "home#index" #Calls index method of home controller, then displays index view for home

	get 'home/about' #Creates a new route called "home_about"
	get 'home/login'
	get 'home/signup'
	get 'home/personal_home'
    get 'personal_home/index'
    get 'personal_home/set_cookies'

	# Add resource to get the standard RESTful actions for sessions
	#get 'sessions/new'
	#get '/login',       to: 'sessions#new'
	#post '/login',      to: 'session#create' 
	#delete '/logout',   to: 'session#destroy'

	resources :users
	resources :transactions

  get '/upload' => 'items#new'
  get '/user_items/:id' => 'items#user_items'
  get '/search' => 'items#search'
  get '/remove_item/:id' => 'items#remove', as: 'remove_item'
  resources :items

end
