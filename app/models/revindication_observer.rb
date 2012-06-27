class RevindicationObserver < ActiveRecord::Observer
  def after_commit(revindication)
    CandidateMailer.revindication(revindication.candidate_id, revindication.user_id).deliver
  end
end
