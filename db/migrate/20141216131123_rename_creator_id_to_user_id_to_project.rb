class RenameCreatorIdToUserIdToProject < ActiveRecord::Migration
  def change
    rename_column :projects, :creator_id, :user_id
  end
end
