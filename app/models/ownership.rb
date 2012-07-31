class Ownership < ActiveRecord::Base
  attr_accessor :terms_and_conditions

  belongs_to :user
  belongs_to :candidate

  validates_acceptance_of :terms_and_conditions
  validates_presence_of :candidate, :user

  def self.send_revindication_to_some_candidates (head, tail)
    candidates = Candidate.where("email != 'candidate@email.com'").order(:id)
    candidates[head.to_i..tail.to_i].each do |candidate|
      CandidateMailer.revindication(candidate.id).deliver
    end
  end
end
