class CreateStrands < ActiveRecord::Migration[5.0]
  def change
    create_table :strands do |t|
      t.integer :number
      t.text :description
      t.belongs_to :objective, foreign_key: true

      t.timestamps
    end
  end
end
