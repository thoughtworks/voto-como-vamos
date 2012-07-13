class Opinion < ActiveRecord::Base
  AGREE = 1
  DISAGREE = -1

  belongs_to :user
  belongs_to :proposal
  attr_accessible :value, :id
  attr_accessible :user_id, :proposal_id, :value, :id, :as => :admin

  validates_presence_of :user, :proposal
  validates_uniqueness_of :user_id, :scope => [:proposal_id]
  validates_inclusion_of :value, :in => [AGREE, DISAGREE]

  scope :agreements, where(:value => AGREE)
  scope :disagreements, where(:value => DISAGREE)

  def agree?
    value == AGREE
  end

  def disagree?
    !agree?
  end

  def self.opinion_for proposal, user
    where(user_id: user, proposal_id: proposal).first
  end
end
