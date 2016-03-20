class CreateCourseObjectives < ActiveRecord::Migration[5.0]
  def change
    create_table :course_objectives do |t|
      t.references :course, foreign_key: true
      t.references :objective, foreign_key: true

      t.timestamps
    end
  end
end
