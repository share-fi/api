# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/db.sqlite")

class User
	include DataMapper::Resource
  include BCrypt

	property :id, Serial, :key => true
	property :created_at, DateTime
	property :username, String, :length => 15
	property :name, String
	property :password, BCryptHash
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
