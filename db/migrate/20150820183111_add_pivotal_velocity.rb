class AddPivotalVelocity < ActiveRecord::Migration
  def change
    add_column :pivotal_projects, :current_velocity, :integer
    add_column :pivotal_projects, :current_volatility, :integer
  end
end
