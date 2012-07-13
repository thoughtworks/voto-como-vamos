class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.integer :id
      t.belongs_to :user
      t.belongs_to :proposal
      t.boolean :agree

      t.timestamps
    end
    add_index :opinions, :user_id
    add_index :opinions, :proposal_id
  end
end
