class AddObfuscatedSlugToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :obfuscated_slug, :string
  end
end
