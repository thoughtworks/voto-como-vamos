class Question < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  attr_accessible :answer, :description
end
