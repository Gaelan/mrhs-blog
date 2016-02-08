class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :year
      t.integer :session
      t.integer :period
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
