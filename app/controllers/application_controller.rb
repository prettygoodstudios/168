class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def index
    if user_signed_in?
      @weeks = Week.myWeeks current_user
    else
      redirect_to new_user_registration_path
    end
  end
  
end
