class MainSearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :query, :candidates, :proposals

  def initialize(options = {})
    @query = options[:query]
  end

  def persisted?
    false
  end

  def execute
    @candidates = Candidate.text_search(@query)
    @proposals = Proposal.text_search(@query)
    self
  end

  def empty?
    candidates.results.empty? && proposals.results.empty?
  end
end
