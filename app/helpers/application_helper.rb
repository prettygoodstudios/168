module ApplicationHelper
  def login_helper
    if user_signed_in?
      render partial: "shared/profile"
    else
      ("<li>".html_safe + (link_to "Login", new_user_session_path, class: 'nav-option') + "</li><li>".html_safe + (link_to "Register", new_user_registration_path, class: 'nav-option'))
    end
  end
  def weeks_helper weeks
    if user_signed_in?
      display = "<ul class='week-list'>".html_safe
      weeks.each do |week|
        display += "<li class='week-item'>".html_safe
        startDate = week.start.strftime("%a, %d %b %Y").html_safe
        display += "<span>#{startDate}</span><div class='option-group'>".html_safe
        display += link_to fa_icon("eye"), "weeks/#{week.id}", class: 'week-option', style:'margin-left:50px;'
        display += link_to fa_icon("trash"), week_path(week.id),class: 'week-option',style:'margin-left:5px;', method: :delete
        display += "</div></li>".html_safe
      end
      display += "</ul>".html_safe
      return display
    end
  end
  
  def add_week time
    time + (7)
  end
  def week_event week
    res = "".html_safe
    7.times do |day|
      res += "<li class='events-group'><div class='top-info'><span>#{Date::DAYNAMES[day]} #{link_to "Create Event", new_event_path(day: Date::DAYNAMES[day],week: week), class: 'btn btn-success create'}</span></div><ul>".html_safe
      if week.days.find_by_name(Date::DAYNAMES[day]).events.size != 0
        tally = 0
        week.days.find_by_name(Date::DAYNAMES[day]).events.each do |event|
          tally += 1
          res += "<li class='single-event' data-start='#{event.start.to_s}:#{event.minstart.to_s}' data-begin='#{amPm event.start,min: event.minstart}' data-done='#{amPm event.done,min: event.minend}' data-end='#{event.done.to_s}:#{event.minend}' data-content='event-abs-circuit' data-event='event-#{tally.to_s}'>".html_safe
          res += link_to "<em class='event-name'>#{event.name}</em>".html_safe, event_path(event.id)
          res += "</li>".html_safe
        end
      end
      res += "</ul></li>".html_safe
    end
    res
  end
  
  def render_event week
    res = "".html_safe
    7.times do |day|
      if day == 3
        res += "</div></div><div class='col-md-6 event-half'><div class='row'>".html_safe
      end
      res += "<div class='day col-md-3'><div class='title'><h1>#{Date::DAYNAMES[day]}</h1> #{link_to fa_icon("plus-square-o"), new_event_path(day: Date::DAYNAMES[day],week: week),class: "add-week"}</div><div class='time-slot'>".html_safe
      if day % 2 == 0
        res += "<div class='cal-stripe' style='background-color:#ffffff'></div>".html_safe
      else 
        res += "<div class='cal-stripe' style='background-color:#efebe9'></div>".html_safe
      end
      if week.days.find_by_name(Date::DAYNAMES[day]).events.size != 0
        tally = 0
        week.days.find_by_name(Date::DAYNAMES[day]).events.each do |event|
          tally += 1
          res += "<div class='event' style='top:#{event.start*100+event.minstart*10/6}px;width:100%;height:#{(event.done-event.start)*100+(event.minend-event.minstart)*10/6}px' data-start='#{event.start.to_s}:#{event.minstart.to_s}' data-begin='#{amPm event.start,min: event.minstart}' data-done='#{amPm event.done,min: event.minend}' data-end='#{event.done.to_s}:#{event.minend}'>".html_safe
          res += link_to event.name , event_path(event.id)
          res += "<p>#{amPm event.start, min: event.minstart} - #{amPm event.done, min: event.minend}</p>".html_safe
          res += "</div>".html_safe
        end
      end
      res += "</div></div>".html_safe
    end
    #res += "<div class='col-md-3 hours'><div class='title'><h1>Time</h1></div><ul>#{ realTimeline }</ul></div>".html_safe
    res += "</div></div>".html_safe
    res
  end
  def find_date week, day
    7.times do |d|
      if Date::DAYNAMES[d] == day.name
        return week.start + d
      end
    end
  end
  def amPm time, options = {}
    min = options[:min]
    time = time.floor
    sec =  ':'+min.to_s
    if min != nil && min != 0
      if time < 12 && time != 0
        return (time).to_s + "#{sec} Am"
      elsif time == 0
        return (12).to_s + "#{sec}  Am"
      elsif time != 12 && time - 12 != 12
        return (time - 12).to_s + "#{sec} Pm"
      elsif time - 12 != 12
        return (12).to_s + "#{sec}  Pm"
      else
        return (12).to_s + "#{sec}  Am"
      end
    else
      if time < 12 && time != 0
        return (time).to_s + " Am"
      elsif time == 0
        return (12).to_s + " Am"
      elsif time != 12 && time - 12 != 12
        return (time - 12).to_s + " Pm"
      elsif time - 12 != 12
        return (12).to_s + " Pm"
      else
        return (12).to_s + " Am"
      end
    end
  end
  
  def militaryTime time
    time.to_s + ":00"
  end
  def timelinehelper
   res = "<li><span>0:00</span></li>".html_safe
   hour = 0
   min = 0 
   48.times do |i| 
     if min == 0 
       min = 30 
       if hour < 10 
        res +="<li><span>0#{hour.to_s}:30</span></li>".html_safe
       else
        res +="<li><span>#{hour.to_s}:30</span></li>".html_safe
       end
     else
       hour += 1 
       min = 0 
       if hour < 10
        res +="<li><span>0#{hour.to_s}:00</span></li>".html_safe
       else
        res +="<li><span>#{hour.to_s}:00</span></li>".html_safe
       end
     end 
   end
   res
  end
  
  def realTimeline
   res = "<li><span>12:00 AM</span></li>".html_safe
   hour = 0
   min = 0 
   48.times do |i| 
     if min == 0 
       min = 30 
       if hour < 10 
         if hour == 0 
          res +="<li><span>12:30 AM</span></li>".html_safe
         else
          res +="<li><span>0#{hour.to_s}:30 AM</span></li>".html_safe
         end
       elsif hour < 13
        if hour == 12
          res +="<li><span>#{hour.to_s}:30 PM</span></li>".html_safe
        else
          res +="<li><span>#{hour.to_s}:30 AM</span></li>".html_safe
        end
       else
         res +="<li><span>#{(hour-12).to_s}:30 PM</span></li>".html_safe
       end
     else
       hour += 1 
       min = 0 
       if hour < 10
        res +="<li><span>0#{hour.to_s}:00 AM</span></li>".html_safe
       elsif hour < 13
        if hour == 12
          res +="<li><span>#{hour.to_s}:00 PM</span></li>".html_safe
        else
          res +="<li><span>#{hour.to_s}:00 AM</span></li>".html_safe
        end
       else
        if hour - 12 == 12
          res +="<li><span>#{(hour-12).to_s}:00 AM</span></li>".html_safe
        else 
          res +="<li><span>#{(hour-12).to_s}:00 PM</span></li>".html_safe
        end
       end
     end 
   end
   res
  end
  def gravatar_url(email, size)
    gravatar = Digest::MD5::hexdigest(email).downcase
    url = "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}"
  end
end
