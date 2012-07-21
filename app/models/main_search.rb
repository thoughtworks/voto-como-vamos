class MainSearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :query, :candidate_results, :proposal_results

  def initialize(options = {})
    @query = options[:query]
  end

  def persisted?
    false
  end

  def execute
    @candidate_results = Candidate.text_search(@query)
    @proposal_results = Proposal.text_search(@query)
    self
  end
end
