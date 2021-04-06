class DeleteAdminFromUserEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_events, :admin, if_exists: true
  end
end
