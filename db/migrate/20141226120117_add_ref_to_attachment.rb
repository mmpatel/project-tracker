class AddRefToAttachment < ActiveRecord::Migration
  def change
    add_reference :attachments, :issue, index: true
  end
end
