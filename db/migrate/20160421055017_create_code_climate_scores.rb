class CreateCodeClimateScores < ActiveRecord::Migration
  def change
    create_table :code_climate_scores do |t|
      t.references :project, index: true, foreign_key: true
      t.float :score

      t.timestamps null: false
    end
  end
end
