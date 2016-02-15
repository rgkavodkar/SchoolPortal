class UsersController < ApplicationController
	
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(check_user_params)
		if @user.save
			redirect_to @user
		else
			render 'new'
		end
	end

	private
	def check_user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :utype)
	end
end
