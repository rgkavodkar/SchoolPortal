class AnnouncementsController < ApplicationController
	before_action :logged_user, only: [:new, :index]

 	def new
 		if current_user.utype == "instructor"

			if Course.where(user_id:current_user.id).count == 0
				# instructor doesnt have any courses, cant make an announcement
				redirect_to nocourses_url
			else
				@relevant_courses = Course.all.map{|course| [course.title, course.id] if course.user_id == current_user.id}
				@announcement = Announcement.new
			end
		else 
			redirect_to unauthorized_url
		end
  	end

  	def create
	  	@announcement = Announcement.new(check_announcement_params)
  		if @announcement.save
			flash[:success] = "Announcement posted!"
			redirect_to current_user
		else
		end
	
  	end

  	def index
  		# course_id = User.find(params[:course_id])
  		# @course_announcements = Announcement.where(course_id: course_id)
  	end

  	private
	def check_announcement_params
		params.require(:announcement).permit(:title, :content, :course_id)
	end

	def logged_user
		unless logged_in?
			redirect_to login_url
		end
	end
end
