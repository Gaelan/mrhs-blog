class AddGivenAndFamilyNamesToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :given_name, :text
    add_column :users, :family_name, :text
    User.find_each do |user|
      name = user.name.split(nil, 2)
      user.update(given_name: name[0], family_name: name[1])
    end
  end

  def down
    remove_column :users, :given_name, :text
    remove_column :users, :family_name, :text
  end
end
