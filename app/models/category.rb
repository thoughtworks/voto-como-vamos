# encoding: utf-8
class Category < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :proposals

  validates :name, :presence => true,
                   :length => { :maximum => 255 }
end
