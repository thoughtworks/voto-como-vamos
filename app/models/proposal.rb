# encoding: utf-8
class Proposal < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_and_belongs_to_many :categories

  belongs_to :candidate
  validates :candidate, :presence => true

  validates :title, 
    :presence => true,
    :length => { :maximum => 100 }

  validates :abstract, 
    :presence => true,
    :length => { :maximum => 300 }

  validates :description, :presence => true

  def self.search(query_string, categories = nil)
    tire.search(query_string, :load => true) do
      filter :terms, :categories => [categories] if categories
    end
  end

  mapping do
    indexes :title, :analyzer => 'snowball', :boost => 3
    indexes :abtract, :analyzer => 'snowball', :boost => 2
    indexes :description, :analyzer => 'snowball', :boost => 1
    indexes :categories, :analyzer => 'keyword' 
  end

  def to_indexed_json
    {
      :title => title,
      :abstract => abstract,
      :description => description,
      :categories => categories.map { |c| c.name }
    }.to_json
  end
end
