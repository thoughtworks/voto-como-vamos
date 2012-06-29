# encoding: utf-8

class Category < ActiveRecord::Base

  validates :name, :presence => true,
                   :length => { :maximum => 255 }

end
