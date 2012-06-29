# encoding: utf-8

class Proposal < ActiveRecord::Base

  has_and_belongs_to_many :categories

  belongs_to :candidate
  validates :candidate, :presence => true

  validates :title, :presence => true,
                    :length => { :maximum => 100 }

  validates :abstract, :presence => true,
                       :length => { :maximum => 300 }

  validates :description, :presence => true

end
