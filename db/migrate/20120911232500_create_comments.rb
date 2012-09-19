class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :fb_comment_id
      t.integer :proposal_id
      t.integer :user_id

      t.timestamps
    end
  end

  def down
  end
end
