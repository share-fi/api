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

# Tell DataMapper to finalize its modules
DataMapper.finalize

# Update database according to what's defined above
DataMapper.auto_upgrade!

# The fun begins
# :-)

get '/'  do
	slim :index
end