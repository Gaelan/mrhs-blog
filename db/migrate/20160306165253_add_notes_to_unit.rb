class AddNotesToUnit < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :notes, :text
  end
end
