class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def index
    if user_signed_in?
      @weeks = Week.myWeeks current_user
    end
  end
  
end
