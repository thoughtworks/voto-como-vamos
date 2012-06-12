class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
    end
  end

  def down
    drop_table :users
  end
end
