class ResortPostController < ApplicationController


	# index all posts

	get '/' do
		posts = Resort_Post.all.order(:created_at)
		{
			status: 200,
			message: "You have hit all posts",
			posts: posts
		}.to_json

	end


	# index user-posts

	get '/my-posts' do
		user = User.find_by username: session[:username]
		{
			status: 200,
			posts: user.resort_posts.order(:id),
			message: "this is all #{user.username}'s posts"
		}.to_json

	end



	# create post

	post '/' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		# binding.pry

		user = User.find_by username: session[:username]
		resort_post = Resort_Post.new
		resort_post.resort = payload[:resort]
		resort_post.body = payload[:body]
		resort_post.user_id = user.id
		resort_post.save
		{
			status: 200,
			message: "Made Post",
			resort_post: resort_post
		}.to_json
	end


	# edit post
	put '/:id' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		resort_post = Resort_Post.find params[:id]

		resort_post.resort = payload[:resort]
		resort_post.body = payload[:body]
		resort_post.save
		{
			status: 200,
			message: "Post has been updated",
			resort_post: resort_post
		}.to_json
	end
	

	#delete post
	delete '/:id' do
		resort_post = Resort_Post.find params[:id]

		resort_post.destroy
		{
			status: 200,
			message: "Deleted Post"
		}.to_json
	end


end
















