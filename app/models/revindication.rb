class Revindication < ActiveRecord::Base
  attr_accessor :terms_and_conditions

  belongs_to :candidate
  belongs_to :user

  validates_acceptance_of :terms_and_conditions
  validates_presence_of :user
  validates_presence_of :candidate
end
