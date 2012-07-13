class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal
  attr_accessible :agree, :id
end
