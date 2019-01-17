class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	require 'dotenv'
	Dotenv.load

	use Rack::Session::Cookie,  :key =>'rack.session',
								:path => '/',
								:secret => ENV['SECRET_KEY']

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'ski_report_app'

	)

	register Sinatra::CrossOrigin


	configure do
		enable :cross_origin
	end


	set :allow_origin, :any
	set :allow_credentials, true
	set :allow_methods, [:get, :post, :put, :patch, :delete, :options]


	options '*' do
		response.headers['Allow'] = 'HEAD, GET, POST, PATCH, DELETE, OPTIONS'
		response.headers['Access-Control-Allow-Origin'] = ENV['REACT_APP_ADDRESS']
		response.headers['Access-Control-Allow-Credentials'] = 'true'
		response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Authorization, Content-Type, Cache-Control, Accept'
		200
	end



	get '/' do
		# binding.pry
		{
			status: 200,
			message: "We are up and running"
		}.to_json

	end



end