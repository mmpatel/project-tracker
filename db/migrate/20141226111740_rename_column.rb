class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :attachments, :url, :avatar
  end
end
