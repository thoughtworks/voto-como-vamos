class AddShortNameToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :short_name, :string
  end
end
