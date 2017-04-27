class AddDefaultValueToActiveQuestion < ActiveRecord::Migration
  def change
    change_column :questions, :active, :boolean, :default => true
  end
end
