class Week < ApplicationRecord
  validate :start, :uniqueWeek, :isSunday
  has_many :days, dependent: :destroy
  belongs_to :user
  
  def uniqueWeek
    res = false
    Week.all.each do |w|
      if w.start == start
        res = true
      end
    end
    if res
      errors.add(:start, "Start must be unique.")
    end
  end
  def isSunday
    if start != nil
      if !start.sunday?
        errors.add(:start, "Start must be Sunday.")
      end
    else
      errors.add(:start, "Start must be selected.")
    end
  end
end
