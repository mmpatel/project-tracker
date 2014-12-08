class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :access_level
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
