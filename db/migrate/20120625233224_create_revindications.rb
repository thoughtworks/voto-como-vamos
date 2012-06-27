class CreateRevindications < ActiveRecord::Migration
  def up
    create_table :revindications do |t|
      t.integer :candidate_id
      t.string  :user_id
      t.boolean :accepted
    end
  end

  def down
    drop_table :revindications
  end
end
