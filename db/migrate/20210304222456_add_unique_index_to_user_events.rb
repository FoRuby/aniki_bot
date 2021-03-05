class AddUniqueIndexToUserEvents < ActiveRecord::Migration[6.1]
  def change
    add_index :user_events, %i[user_id event_id], unique: true
  end
end
