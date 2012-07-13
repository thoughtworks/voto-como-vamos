class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.integer :id
      t.belongs_to :user
      t.belongs_to :proposal
      t.integer :value

      t.timestamps
    end

    add_index :opinions, [:user_id, :proposal_id], :unique => true
    add_index :opinions, :user_id
    add_index :opinions, :value
    add_index :opinions, :proposal_id
  end
end
