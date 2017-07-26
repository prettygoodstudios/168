class Application < ApplicationRecord
  def self.myWeeks
    where(user_id: current_user.id)
  end
end