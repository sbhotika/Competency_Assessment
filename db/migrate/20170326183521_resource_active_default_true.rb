class ResourceActiveDefaultTrue < ActiveRecord::Migration
  def change
    change_column :resources, :active, :boolean, :default => true
  end
end
