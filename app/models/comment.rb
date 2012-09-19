class Comment < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validates :proposal, :user, :presence => true

  after_commit :notify_candidate, :on => :create

  def notify_candidate
    CandidateMailer.notify_comment(proposal.id).deliver
  end
end
