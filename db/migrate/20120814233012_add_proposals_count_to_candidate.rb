class AddProposalsCountToCandidate < ActiveRecord::Migration
  
  def up
    add_column :candidates, :proposals_count, :integer, :default => 0
    Candidate.all.each {|c| Candidate.update(c.id, :proposals_count => c.proposals.count, :as => :migration_admin) }
  end
  
  def down
    remove_column :candidates, :proposals_count
  end
end
