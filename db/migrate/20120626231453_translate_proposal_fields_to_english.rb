class TranslateProposalFieldsToEnglish < ActiveRecord::Migration
  def up
    rename_column :proposals, :resumo, :abstract
    rename_column :proposals, :descricao, :description
  end

  def down
    rename_column :proposals, :abstract, :resumo
    rename_column :proposals, :description, :descricao
  end
end
