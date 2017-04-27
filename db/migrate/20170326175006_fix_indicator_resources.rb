class FixIndicatorResources < ActiveRecord::Migration
  def change
    rename_column :indicator_resources, :indictaor_id, :indicator_id
  end
end
