class CreateTaskStrands < ActiveRecord::Migration[5.0]
  def change
    create_table :task_strands do |t|
      t.belongs_to :task, foreign_key: true
      t.belongs_to :strand, foreign_key: true

      t.timestamps
    end
  end
end
