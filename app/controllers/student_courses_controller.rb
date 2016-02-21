class StudentCoursesController < ApplicationController
  before_action :logged_user, only: [:show, :edit, :update, :destroy, :index]
  before_action :set_student_course, only: [:show, :edit, :update, :destroy]

  # GET /student_courses
  # GET /student_courses.json
  def index
    @student_courses = StudentCourse.all
  end

  # GET /student_courses/1
  # GET /student_courses/1.json
  def show
  end

  # GET /student_courses/new
  def new
    @student_course = StudentCourse.new
  end

  # GET /student_courses/1/edit
  def edit
  end

  # POST /student_courses
  # POST /student_courses.json
  def create
    @student_course = StudentCourse.new(student_course_params)

    respond_to do |format|
      if @student_course.save
        format.html { redirect_to @student_course}
         flash[:success] = "Student has been in the pending list for the course , till approval"
        format.json { render :show, status: :created, location: @student_course }
      else
        format.html { render :new }
        format.json { render json: @student_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_courses/1
  # PATCH/PUT /student_courses/1.json
  def update
    respond_to do |format|
      if @student_course.update(student_course_params)
        format.html { redirect_to @student_course}
        flash[:success] = "Updated the course-student details"
        format.json { render :show, status: :ok, location: @student_course }
      else
        format.html { render :edit }
        format.json { render json: @student_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_courses/1
  # DELETE /student_courses/1.json
  def destroy
    @student_course.destroy
    respond_to do |format|
      format.html { redirect_to course_history_display_url}
      flash[:success] = "Student was succesfully removed from the course"
    end
  end

  def enrolledshow
      @student_courses = StudentCourse.all.map{|course| course if ((course.course_id == params[:id].to_i) && (course.status=="enrolled"))}
  end

  def pendingshow
      @student_courses = StudentCourse.all.map{|course| course if ((course.course_id == params[:id].to_i) && (course.status=="pending"))}
  end

  def complete
    if params[:Enrollment]
      StudentCourse.where("id=?",params[:student_course_ids]).update_all(["status=?", "enrolled"])
      redirect_to coursehistorydisplayinstructor_url
    else
      StudentCourse.where("id=?",params[:student_course_ids]).delete_all
      redirect_to coursehistorydisplayinstructor_url
    end  
  end



  


  def course_history_display
   if logged_in?
    @student_courses = StudentCourse.all.map{|course| course if (course.user_id == current_user.id)}
  else
    redirect_to login_path
   end 
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_course
      @student_course = StudentCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_course_params
      params.require(:student_course).permit(:user_id, :course_id, :grade)
    end

    def logged_user
    unless logged_in?
      redirect_to login_url
    end
  end
end
