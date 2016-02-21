class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to current_user
    end
  end

  def about
  end

  def contact
  end

  def unauthorized
  end
  
  def no_courses
  end
end
