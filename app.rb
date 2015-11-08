# Require all gems in Gemfile :-)
require 'bundler'
Bundler.require

# Models is in another file because it doesn't belong here
require_relative 'models'

# Sessions are basically going to make my life not a living hell hopefully
enable :sessions

# Get index page
get '/'  do
	slim :index
end

# Get Sign up Page
get '/signup' do
	slim :signup
end

# Get Login Page
get '/login' do
	slim :login
end

# Get dashboard
get '/dashboard' do
	slim :dashboard
end

# Get create new network page
get '/create' do
	slim :create
end

# Get all networks ordered
get '/networks' do
	content_type :json

	@networks = Network.all(:order => :created_at.desc)
	@networks.to_json
end

post '/signup' do
	@user = User.new(params[:user])
	if @user.save
		redirect '/dashboard'
	else
		redirect '/signup'
	end
end

# Get user profile
get '/u/:user' do
	@user = User.get(user)
	if @user
		slim :user
	else
		slim :error
	end
end

# Post create new network
post '/create/:id' do
	network = Network.new(id)

	if network.save
		redirect '/networks'
	else
		redirect '/create/network'
	end
end

# Get network via unique ID
get '/n/:id' do
	@network = Network.get(id)
	if @network
		slim :network
	else
		slim :error
	end
end
