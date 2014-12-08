class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.string :description

      t.timestamps
    end
  end
end
