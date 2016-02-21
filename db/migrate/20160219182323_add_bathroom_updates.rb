class AddBathroomUpdates < ActiveRecord::Migration
  def change
    create_table :bathroom_updates do |t|
      t.boolean :occupied
      t.integer :room

      t.timestamps null: false
    end
  end
end
