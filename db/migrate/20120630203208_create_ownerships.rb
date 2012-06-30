class CreateOwnerships < ActiveRecord::Migration
  def up
    create_table :ownerships do |t|
      t.integer :user_id
      t.integer :candidate_id
    end
  end

  def down
    drop_table :ownerships
  end
end
