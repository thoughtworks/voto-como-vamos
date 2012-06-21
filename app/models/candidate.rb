class Candidate < ActiveRecord::Base

  has_many :proposals

  validates :name, presence: true

end
