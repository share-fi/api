# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/db.sqlite")

class User
	include DataMapper::Resource
  include BCrypt

	property :id, Serial, :key => true
	property :created_at, DateTime
	property :email, String
	property :username, String, :length => 3...15
	property :password, String #,BCryptHash
	property :verified, Boolean
end

class Network
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :created_at, DateTime
	property :ssid, String, :length => 1...32
	property :password, String
	property :location_name, String
	property :comments, String
	property :longitude, String
	property :latitude, String
end

# Let DataMapper know to finalize its modules and update the database
DataMapper.finalize.auto_upgrade!
