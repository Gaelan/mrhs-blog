class CreateCourseUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :course_units do |t|
      t.belongs_to :course, foreign_key: true
      t.belongs_to :unit, foreign_key: true

      t.timestamps
    end
  end
end
