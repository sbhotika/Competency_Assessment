class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :paradigm_id
      t.string :title
      t.text :link
      t.boolean :active

      t.timestamps null: false
    end
  end
end
