# Require all gems in Gemfile :-)
require 'bundler'
Bundler.require

# Models is in another file because it doesn't belong here
require_relative 'models'

# Sessions are basically going to make my life not a living hell hopefully
enable :sessions

helpers do
	def login?
    if session[:user].nil?
      return false
    else
      return true
    end
  end

  def username
    return session[:username]
  end
end

# Get index page
get '/'  do
	slim :index
end

get '/dashboard' do
	@username = username
	slim :dashboard
end

get '/signup' do
	slim :signup
end

get '/login' do
	slim :login
end

get '/dashboard' do
	@username = session[:username]
	slim :dashboard
end

get '/create' do
	slim :create
end

get '/browse' do
	@networks = Network.all(:order => :created_at.desc)
	slim :browse
end

post '/signup' do
	@user = User.new(params[:user])
	if @user.save
		redirect '/dashboard'
	else
		redirect '/signup'
	end
end

get '/u/:user' do
	@user = User.get(user)
	if @user
		slim :user
	else
		slim :error
	end
end

get '/browse' do
	slim :browse
end

# Post create new network
post '/create' do
	@net = Network.new(params[:network])
	if @net.save
		redirect '/browse'
	else
		redirect '/create'
	end
end

get '/users' do
	@users = User.all
	slim :users
end

get '/search' do
	slim :search
end

get '/network' do
	slim :network
end

get '/logout' do
	session[:user] = nil
	redirect '/'
end

get '/error' do
	slim :error
end

post '/login' do
	redirect '/dashboard'
end
