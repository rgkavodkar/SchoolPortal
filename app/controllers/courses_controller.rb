class CoursesController < ApplicationController
    before_action :logged_user, only: [:show, :edit, :update, :destroy, :index]
    before_action :set_course, only: [:show, :edit, :update, :destroy]

    # GET /courses
    # GET /courses.json
    def index
        # @courses = Course.all

        if params[:search].blank?
            @courses = Course.all.order('created_at DESC')
        elsif params[:search]
            if params[:searchby] == 'ID'
                @courses = Course.where("id like #{params[:search]}")
            elsif params[:searchby] == 'Title'
                @courses = Course.where("title LIKE ?","%#{params[:search]}%")
            elsif params[:searchby] == 'Description'
                @courses = Course.where("description LIKE ?","%#{params[:search]}%")
            elsif params[:searchby] == 'Instructor'
                @courses = Course.joins(:user).merge(User.where(" name like ?","%#{params[:search]}%"))
            elsif params[:searchby] == 'Status'
                @courses = Course.where("lower(status) = ?","#{params[:search].downcase}")
            end 
        else
            @courses = Course.all.order('created_at DESC')
        end
    end

    # GET /courses/1
    # GET /courses/1.json
    def show
        @course_announcements = Announcement.where(course_id:@course.id)
    end

    # GET /courses/new
    def new
        if current_user.utype == "admin"
            @course = Course.new
        else
            redirect_to unauthorized_url
        end
    end

    # GET /courses/1/edit
    def edit
    end

    # POST /courses
    # POST /courses.json
    def create
        if current_user.utype == "admin"
            @course = Course.new(course_params)

            respond_to do |format|
                if @course.save
                    format.html { redirect_to @course }
                    flash[:success] ='Course was successfully created.'
                    format.json { render :show, status: :created, location: @course }
                else
                    format.html { render :new }
                    format.json { render json: @course.errors, status: :unprocessable_entity }
                end
            end
        else
            redirect_to unauthorized_url
        end
    end

    # PATCH/PUT /courses/1
    # PATCH/PUT /courses/1.json
    def update
        respond_to do |format|
            if @course.update(course_params)
                format.html { redirect_to @course}
                flash[:success] ='Course was successfully updated.'
                format.json { render :show, status: :ok, location: @course }
            else
                format.html { render :edit }
                format.json { render json: @course.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /courses/1
    # DELETE /courses/1.json
    def destroy
        student_count = StudentCourse.where(course_id:@course.id, status:"enrolled").count
        if student_count > 0
            flash[:danger] = "Cannot delete a course with enrolled students"
            redirect_to @course
        else      
            @course.destroy
            respond_to do |format|
                format.html { redirect_to courses_url}
                flash[:success] ='Course was successfully destroyed.' 
                format.json { head :no_content }
            end
        end
    end

    # POST /student_courses
    # POST /student_courses.json
    def enroll

        if (StudentCourse.where("user_id=? AND course_id=?",current_user.id,params[:id]).empty?)
            @student_course = StudentCourse.new
            @student_course.user_id = current_user.id
            @student_course.course_id = params[:id]
            @student_course.grade= 'F'
            @student_course.status = 'pending'
            respond_to do |format| 
                if @student_course.save
                    format.html { redirect_to course_history_display_url}
                    flash[:success] = "A request has been sent to instructor to add you to the course." 
                    format.json { render :show, status: :created, location: @student_course }
                else
                    format.html { render :index}
                    format.json { render json: @student_course.errors, status: :unprocessable_entity }
                end
            end 
        else
            redirect_to courses_url
            flash[:success] ='Student already enrolled for course.'
        end  
    end

    def coursehistorydisplayinstructor
        if logged_in?
            @courses = Course.all.map{|course| course if (course.user_id == current_user.id)}
        else
            redirect_to login_path
        end 
    end  

    def get_instructor_history
        if logged_in?
            if current_user.utype == "admin"
                user = User.find(params[:user])
                @courses = Course.all.map{|course| course if (course.user_id == user.id)}
                @instructor = user
            else
                redirect_to unauthorized_url 
            end
        else
            redirect_to login_path
        end 
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
        @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
        params.require(:course).permit(:title, :description, :start_date, :end_date, :user_id, :status)
    end

    

    def logged_user
        unless logged_in?
            redirect_to login_url
        end
    end
end
