class UserSessionController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:user_session][:email].downcase)
		if user && user.authenticate(params[:user_session][:password])
			flash[:success] = 'Welcome'
			log_in user
			redirect_to user
		else
			flash[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end
end
