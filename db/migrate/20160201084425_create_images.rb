class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :caption
      t.string :src
      t.string :maker
      t.attachment :file

      t.timestamps null: false
    end
  end
end
