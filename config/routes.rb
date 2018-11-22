Rails.application.routes.draw do



	root "home#index" #Calls index method of home controller, then displays index view for home

	get 'home/about' #Creates a new route called "home_about"
	get 'home/login'
	get 'home/signup'
	get 'home/personal_home'

	# Add resource to get the standard RESTful actions for sessions
	#get 'sessions/new'
	#get '/login',       to: 'sessions#new'
	#post '/login',      to: 'session#create' 
	#delete '/logout',   to: 'session#destroy'

	resources :users
	resources :transactions

end
