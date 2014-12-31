class AddDetailsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :type, :string
    add_column :attachments, :model_id, :integer
    add_column :attachments, :url, :string
    add_column :attachments, :creator_id, :integer
  end
end
