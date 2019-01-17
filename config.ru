require 'sinatra/base'



# controller
require './controllers/ApplicationController';
require './controllers/UserAPIController'
require './controllers/ResortPostController'




# models
require './models/UserModel'
require './models/ResortPostModel'


# map routes
map('/api') {
	run ApplicationController
}

map('/api/users') {
	run UserAPIController
}

map('/api/resort-posts') {
	run ResortPostController
}