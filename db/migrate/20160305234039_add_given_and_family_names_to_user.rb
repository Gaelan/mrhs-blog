class AddGivenAndFamilyNamesToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :given_name, :text
    add_column :users, :given_name_phonetic, :text
    add_column :users, :family_name, :text
    add_column :users, :family_name_phonetic, :text
    add_column :users, :check_name, :boolean
    add_column :users, :preferred_name, :text
    add_column :users, :student_id, :integer
    User.find_each do |user|
      name = user[:name].split(nil, 2)
      user.update(
        given_name: name[0],
        family_name: name[1],
        check_name: user[:name].split.count > 2 ? true : false
      )
    end
  end

  def down
    remove_column :users, :given_name, :text
    remove_column :users, :given_name_phonetic, :text
    remove_column :users, :family_name, :text
    remove_column :users, :family_name_phonetic, :text
    remove_column :users, :check_name, :boolean
    remove_column :users, :preferred_name, :text
    remove_column :users, :student_id, :integer
  end
end
