# encoding: utf-8
class Proposal < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :questions
  has_many :opinions

  belongs_to :candidate, counter_cache: true
  validates :candidate, :presence => true

  validates :title,
    :presence => true,
    :length => { :maximum => 100 }

  validates :abstract,
    :presence => true,
    :length => { :maximum => 300 }

  validates :description, :presence => true

  LIMIT = 5
  scope :ordered_by_votes, order("opinions_count DESC").limit(LIMIT)

  attr_accessible :title, :abstract, :description, :category_ids

  def self.search_in_categories(query_string, categories = [])
    title = "%" << query_string.to_s << "%"
    joins(:categories).where(:categories => {:id => categories}).where("title like ?", title)
  end

  def self.text_search(query_string, page)
    title = "%" << query_string << "%" unless query_string.nil?
    where("title like ?", (title || "")).paginate(:page => page)
  end

  def self.ordered_by_votes_in_the_last_week
    sorted_opinions = Opinion.last_week.group_by(&:proposal_id).each_pair.sort_by { |proposal_id, opinions_array| opinions_array.size }
    sorted_opinions.reverse[0..9].map { |array| Proposal.find(array[0]) }
  end

  def self.ordered_by_creation_date
    Proposal.order("created_at DESC").limit(LIMIT)
  end

end
