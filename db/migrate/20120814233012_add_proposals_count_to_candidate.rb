class AddProposalsCountToCandidate < ActiveRecord::Migration
  
  def up
    add_column :candidates, :proposals_count, :integer, :default => 0
    Candidate.all.each {|c| Candidate.update_counters(c.id, :proposals_count => c.proposals.count) }
  end
  
  def down
    remove_column :candidates, :proposals_count
  end
end
