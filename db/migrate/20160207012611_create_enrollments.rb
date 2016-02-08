class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.references :section, foreign_key: true

      t.timestamps
    end

    add_index(:enrollments, :student_id, {})
    add_foreign_key(:enrollments, :users, column: :student_id)
  end
end
