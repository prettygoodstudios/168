class WeeksController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :login_required
  def login_required
    redirect_to('/') if current_user.blank?
  end
  def show
    @week = Week.find(params[:id])
  end
  
  def create
    @week = current_user.weeks.build(week_params)
    if @week.save
        redirect_to @week, alert: "Week created successfully."
        createDays @week
    else
        redirect_to new_week_path, alert: @week.errors.values[0].join()
    end
  end
  def destroy
    @week = Week.find(params[:id])
    startPoint  = @week.start
    @week.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Week #{startPoint} was deleted." }
      format.json { head :no_content }
    end
  end
  def new
    @week = Week.new
  end
  def edit
    @week = Week.find(params[:id])
  end
  
  private
  
  def week_params
    params.require(:week).permit(:start)
  end
  def createDays week
    7.times do |day|
      week.days.create!(name: Date::DAYNAMES[day])
    end
  end
  
end