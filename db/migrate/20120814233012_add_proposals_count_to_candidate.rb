class AddProposalsCountToCandidate < ActiveRecord::Migration
  
  def up
    add_column :candidates, :proposals_count, :integer, :default => 0
    Candidate.all.each do |c|
      c.update_attribute :proposals_count, c.proposals.count
      c.save
    end
  end
  
  def down
    remove_column :candidate, :proposals_count
  end
end
