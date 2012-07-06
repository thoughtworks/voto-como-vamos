class Ownership < ActiveRecord::Base
  attr_accessor :terms_and_conditions

  belongs_to :user
  belongs_to :candidate

  validates_acceptance_of :terms_and_conditions
  validates_presence_of :candidate, :user

end
