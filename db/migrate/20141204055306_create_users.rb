class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin ,:default => false
      t.boolean :blocked ,:default => true
      t.boolean :can_create_projects ,:default => false
      t.string :state ,:default => "init"
      t.string :avatar_url

      t.timestamps
    end
  end
end
