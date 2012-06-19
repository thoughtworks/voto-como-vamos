class Candidate < ActiveRecord::Base
  validates :name, presence: true
end
