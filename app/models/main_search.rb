class MainSearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :query, :candidates, :proposals

  def initialize(options = {})
    @query = options[:query]
    @candidates_page = options[:candidates_page]
    @proposals_page = options[:proposals_page]
  end

  def persisted?
    false
  end

  def execute
    @candidates = Candidate.text_search(@query, @candidates_page)
    @proposals = Proposal.text_search(@query, @proposals_page)
    self
  end

  def empty?
    candidates.empty? && proposals.empty?
  end
end
