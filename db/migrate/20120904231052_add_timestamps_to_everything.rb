class AddTimestampsToEverything < ActiveRecord::Migration
  def change
    add_timestamps(:ownerships)
    add_timestamps(:proposals)
    add_timestamps(:users)
    add_timestamps(:candidates)
  end
end
