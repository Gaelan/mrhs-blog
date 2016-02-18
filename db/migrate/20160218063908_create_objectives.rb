class CreateObjectives < ActiveRecord::Migration[5.0]
  def change
    create_table :objectives do |t|
      t.string :group
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
