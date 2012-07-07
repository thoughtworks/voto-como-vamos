class Ownership < ActiveRecord::Base
  attr_accessor :terms_and_conditions

  belongs_to :user
  belongs_to :candidate

  validates_acceptance_of :terms_and_conditions
  validates_presence_of :candidate, :user

  def self.send_revindication_to_all_candidates
    candidates = Candidate.all
    candidates.each do |candidate|
      CandidateMailer.revindication(candidate.id).deliver
    end
  end
end
