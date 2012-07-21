# encoding: utf-8
class Proposal < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :questions

  belongs_to :candidate
  validates :candidate, :presence => true

  validates :title,
    :presence => true,
    :length => { :maximum => 100 }

  validates :abstract,
    :presence => true,
    :length => { :maximum => 300 }

  validates :description, :presence => true

  scope :ordered_by_votes, order("opinions_count DESC")

  def self.search_in_categories(query_string, categories = [])
    search do
      fulltext query_string
      with(:category_ids, categories)
    end.results
  end

  searchable do
    text :title, :boost => 5
    text :abstract
    text :description
    integer :category_ids, :multiple => true, :references => Category
  end
end
