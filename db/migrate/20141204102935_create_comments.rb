class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :creator_id
      t.references :issue, index: true

      t.timestamps
    end
  end
end
