class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :title
      t.text :soi
      t.integer :duration

      t.timestamps
    end
  end
end
