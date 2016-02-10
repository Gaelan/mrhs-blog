class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.integer :category
      t.integer :time_required

      t.timestamps
    end
  end
end
