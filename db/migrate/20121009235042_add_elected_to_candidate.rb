class AddElectedToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :elected, :boolean, default: false
  end
end
