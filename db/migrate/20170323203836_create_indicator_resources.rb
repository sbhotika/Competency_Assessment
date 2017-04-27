class CreateIndicatorResources < ActiveRecord::Migration
  def change
    create_table :indicator_resources do |t|
      t.integer :indictaor_id
      t.integer :resource_id

      t.timestamps null: false
    end
  end
end
