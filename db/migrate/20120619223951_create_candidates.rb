class CreateCandidates < ActiveRecord::Migration
  def up
    create_table :candidates do |t|
      t.string :name
      t.string :role
      t.string :party
      t.string :alliance
      t.string :tse_number
      t.string :email
      t.text   :about
      t.string :phone
      t.string :site
      t.string :blog
      t.string :facebook
      t.string :twitter
    end
  end

  def down
    drop_table :candidates
  end
end
