class UserAPIController < ApplicationController

	# login

	post '/login' do 

		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys


		user = User.find_by username: payload[:username]
		password = payload[:password]

		if user && user.authenticate(password)
			session[:logged_in] = true
			session[:username] = user.username
			session[:message] = "session is active"
			{
				status: 200,
				message: "#{user.username} has logged in",
				puts: request.session.inspect

			}.to_json
		else
			{
				status: 401,
				message: "Invalid username or password"
			}.to_json

		end	



	end
	


	# register

	post '/register' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys


		username = payload[:username]
		user_exists = User.find_by username: payload[:username]

		if user_exists
			{
				status: 403,
				message: 'Username Already Exists'
			}.to_json

		else
			user = User.new
			user.username = payload[:username]
			user.password = payload[:password]
			user.save

			session[:lovved_in] = true
			session[:username] = user.username
			{
				status: 200,
				message: "#{user.username} has been created",
				logged_in_as: user.username
			}.to_json
		end
	end


	# logout

	get '/logout' do
		username = session[:username]
		p session
		session.destroy
		{
			username: username,
			status: 200,
			message: "Logged out user #{username}"
		}.to_json

	end



end