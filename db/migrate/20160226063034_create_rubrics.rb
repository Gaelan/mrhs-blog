class CreateRubrics < ActiveRecord::Migration[5.0]
  def change
    create_table :rubrics do |t|
      t.integer :level
      t.references :task
      t.string :band
      t.text :criterion
      t.belongs_to :strand, foreign_key: true
      t.belongs_to :rubricable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
