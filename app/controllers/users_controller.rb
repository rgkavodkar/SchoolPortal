class UsersController < ApplicationController
	before_action :logged_user, only: [:edit, :update, :newadmin, :newinstructor, :index, :show]
	# before_action :logged_in_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def index
		if current_user.utype == "admin"
			@users = User.all
		else 
			# Need to change it to an unauthorized page
			redirect_to unauthorized_url
			# respond_to do |format|
			# 	format.html {redirect_to :controller => 'static_pages', :action => 'unauthorized'}
			# end
		end
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
				flash[:success] = "Welcome to the School Portal!"
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
		user = User.find(params[:id])
		if user.utype == "instructor" && 
			flash[:danger] = "Cannot delete an instructor who is taking a course(s)"
			redirect_to user
		else 
			user.destroy
			redirect_to users_url
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

	def check_deletable_inst(user)
		deletable_inst(user)
	end
end
