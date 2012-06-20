# encoding: utf-8

class CreateProposals < ActiveRecord::Migration
  def up
    create_table :proposals do |t|
      t.string :title, :null => false
      t.integer :candidate_id, :null => false
      t.text :resumo, :null => false
      t.text :descricao, :null => false
    end
  end

  def down
    drop_table :proposals
  end
end
