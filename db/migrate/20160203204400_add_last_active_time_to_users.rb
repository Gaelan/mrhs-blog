class AddLastActiveTimeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_active_time, :datetime
  end
end
