# Require all gems in Gemfile :-)
require 'bundler'
Bundler.require

# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

class User
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :created_at, DateTime
	property :username, String, :length => 15
	property :name, String
end

class Network
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :created_at, DateTime
	property :SSID, String, :length => 32
	property :password, String
end

# Tell DataMapper to finalize its modules
DataMapper.finalize

# Update database according to what's defined above
DataMapper.auto_upgrade!

# The fun begins
# :-)

# Get index page
get '/'  do
	slim :index
end

# Get Sign up Page
get '/signup' do
	# Criteria
	# - username
	# - first name
	# - email
	# - password
	# ------------
	# Also criteria from /create
	slim :signup
end

# Get Login Page
get '/login' do
	slim :login
end

# Get create new network page
get '/create' do
	# Criteria
	# - SSID
	# - network password
	# - location "in english"
	# - location via HTML5 Geolocation
	# - notes(?)
	slim :create
end

# Get all networks ordered
get '/networks' do
	content_type :json

	@networks = Network.all(:order => :created_at.desc)
	@networks.to_json
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
post '/create/:network' do
	network = Network.new(network)

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
