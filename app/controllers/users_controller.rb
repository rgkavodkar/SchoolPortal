class UsersController < ApplicationController
	before_action :logged_user, only: [:edit, :update]
	# before_action :logged_in_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def newstudent
		@user = User.new
	end

	def newadmin
		@user = User.new
	end

	def newinstructor
		@user = User.new
	end

	def create
		@user = User.new(check_user_params)
		if @user.save
			log_in @user
			redirect_to @user
		else
			unless logged_in?
				render 'newstudent'
			else
				# redirect_to(:back)
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(check_user_params)
			redirect_to @user
		else
			render 'edit'
		end
	end

	private
	def check_user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :utype, :ph_number, :address)
	end

	def logged_user
		unless logged_in?
			redirect_to login_url
		end
	end
end
