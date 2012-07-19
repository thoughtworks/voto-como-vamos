class AddOpinionsCountToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :opinions_count, :integer, :default => 0
    add_index :proposals, :opinions_count
  end

  def up
    Proposal.all.each do |p|
      Proposal.update_counters p.id, :opinions_count => p.opinions_count.count
    end
  end
end
