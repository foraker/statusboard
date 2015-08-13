class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repository
      t.string :pivotal_id
    end
  end
end
