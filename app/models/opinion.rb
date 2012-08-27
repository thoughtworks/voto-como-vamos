class Opinion < ActiveRecord::Base
  AGREE = 1
  DISAGREE = -1

  belongs_to :user
  belongs_to :proposal, counter_cache: true
  attr_accessible :value, :id
  attr_accessible :user_id, :proposal_id, :value, :id, :as => :admin

  validates_presence_of :user, :proposal
  validates_uniqueness_of :user_id, :scope => [:proposal_id]
  validates_inclusion_of :value, :in => [AGREE, DISAGREE]

  scope :last_week, lambda { where('updated_at > ?', 7.days.ago) }

  def agree?
    value == AGREE
  end

  def disagree?
    !agree?
  end

  def self.opinion_for proposal, user
    where(user_id: user, proposal_id: proposal).first
  end

  def self.agreements proposal
    where(proposal_id: proposal, value: AGREE)
  end

  def self.disagreements proposal
    where(proposal_id: proposal, value: DISAGREE)
  end
end
