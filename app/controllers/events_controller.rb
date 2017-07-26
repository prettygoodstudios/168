class EventsController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :login_required
  def login_required
    redirect_to('/') if current_user.blank?
  end
  def show
    @event = Event.find(params[:id])
  end
  def edit
    @event = Event.find(params[:id])
  end
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Your Post Is Updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, alert: @event.errors.values[0].join()}
      end
    end
  end
  def create
    week = Week.find_by_id($week)
    day = week.days.find_by_name($day)
    @event = day.events.build(event_params)
    if @event.save
        redirect_to @event, alert: "Event created successfully."
    else
        redirect_to new_event_path(week: $week, day: $day), alert: @event.errors.values[0].join()
    end
  end
  def new
    $week = params[:week]
    $day = params[:day]
    @event = Event.new
  end
  def event_params
    params.require(:event).permit(:start,:done,:name,:minend,:minstart,:description)
  end
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to week_path(params[:week]), notice: 'Event was removed.' }
      format.json { head :no_content }
    end
  end
end