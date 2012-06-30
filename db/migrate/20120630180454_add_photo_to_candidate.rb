class AddPhotoToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :photo, :string
  end
end
