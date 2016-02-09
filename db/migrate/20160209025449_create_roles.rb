class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.references :user, foreign_key: true
      t.integer :type
    end
  end
end
