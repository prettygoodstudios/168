class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.myWeeks current_user
    where(user_id: current_user.id).order('start DESC')
  end
end
