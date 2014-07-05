class PagesController < ApplicationController
  def home
    if user_signed_in?
      @groups = Group.where(user_id: current_user.id)
      @new_group = Group.new
      @new_lesson = Lesson.new
      @profile = Profile.new({user: current_user})

      gon.profile_id = @profile.id

      render 'home_signed_in'
    else
      render 'home'
    end
  end
end
