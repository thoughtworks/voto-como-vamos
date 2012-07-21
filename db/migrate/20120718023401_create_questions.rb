class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :description
      t.belongs_to :proposal
      t.belongs_to :user
      t.text :answer

      t.timestamps
    end
    add_index :questions, :proposal_id
    add_index :questions, :user_id
  end
end
