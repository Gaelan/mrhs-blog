class CreateUnitTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :unit_tasks do |t|
      t.belongs_to :unit, foreign_key: true
      t.belongs_to :task, foreign_key: true

      t.timestamps
    end
  end
end
