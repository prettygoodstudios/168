class Event < ApplicationRecord
  belongs_to :day
  validate :name,:start,:done,:startBefore,:namelength,:minend,:minstart,:timeConflict,:day
  before_save :default_values
  def default_values
    self.minend ||= 0 # note self.status = 'P' if self.status.nil? might be safer (per @frontendbeauty)
    self.minstart ||= 0
  end
  def startBefore
    if start >= done
      errors.add(:start, "The event must last atleast an hour.")
    elsif done - start == 1 && (60-minstart)+minend < 60
      errors.add(:start, "The event must last atleast an hour.")
    end
  end
  def namelength
    if name.length < 3
      errors.add(:name, "Name Must be at least 3 characters long.")
    end
  end
  def timeConflict
    day.events.each do |ev|
      if (ev.start < done && ev.done > start) || (ev.done > start && ev.start < done) || (ev.start == done && ev.minstart <= done) || (ev.done == start && ev.minend >= minstart) || (ev.start > start && ev.done < done) 
        if ev.name != name
          errors.add(:start, "There is a time conflict with another event.")
        end
      end
    end
  end
end
