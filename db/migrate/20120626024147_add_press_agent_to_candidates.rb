class AddPressAgentToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :press_agent, :boolean
  end
end
