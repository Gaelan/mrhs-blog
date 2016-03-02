class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :score
      t.boolean :drop
      t.text :note
      t.belongs_to :user, foreign_key: true
      t.belongs_to :assessment, foreign_key: true
      t.belongs_to :strand, foreign_key: true

      t.timestamps
    end
  end
end
