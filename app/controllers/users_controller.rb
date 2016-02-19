class UsersController < ApplicationController
	before_action :logged_user, only: [:edit, :update, :newadmin, :newinstructor, :index, :show]
	# before_action :logged_in_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def index
		@users = User.all
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
			unless logged_in?
				log_in @user
				redirect_to @user
			else 
				redirect_to current_user
			end
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

	def destroy
		User.find(params[:id]).destroy
		redirect_to users_url
		# respond_to do |format|
		# 	format.html {redirect_to users}
		# 	format.json {head :no_content}
		# end
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
