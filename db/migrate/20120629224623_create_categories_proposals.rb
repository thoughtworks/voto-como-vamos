class CreateCategoriesProposals < ActiveRecord::Migration
  def up
    create_table :categories_proposals do |t|
      t.integer :category_id, :null => false
      t.integer :proposal_id, :null => false
    end
  end

  def down
    drop_table :categories_proposals
  end
end
