class CreateParadigms < ActiveRecord::Migration
  def change
    create_table :paradigms do |t|
      t.string :name
      t.text :description
      t.integer :ranking
      t.boolean :active, default: true 

      t.timestamps null: false
    end
  end
end
