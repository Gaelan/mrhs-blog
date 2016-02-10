class CreateAssessments < ActiveRecord::Migration[5.0]
  def change
    create_table :assessments do |t|
      t.datetime :assigned_date
      t.datetime :due_date
      t.integer :value
      t.integer :weight
      t.integer :autoscore
      t.string :title
      t.integer :category
      t.belongs_to :section, foreign_key: true

      t.timestamps
    end
  end
end
