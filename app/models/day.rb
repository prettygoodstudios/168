class Day < ApplicationRecord
  has_many :events, dependent: :destroy
  belongs_to :week
end
