class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :creator_id
      t.string :description
      t.string :title
      t.string :state
      t.integer :assigned_to
      t.date :completed_by
      t.date :started_on
      t.string :estimate
      t.string :issue_type
      t.references :workflow, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
