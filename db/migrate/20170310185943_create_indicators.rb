class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.integer :competency_id
      t.integer :level_id
      t.text :description
      t.boolean :active,     default: true

      t.timestamps null: false
    end
  end
end
