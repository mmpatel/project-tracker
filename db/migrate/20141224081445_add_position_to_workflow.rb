class AddPositionToWorkflow < ActiveRecord::Migration
  def change
    add_column :workflows, :position, :integer
  end
end
