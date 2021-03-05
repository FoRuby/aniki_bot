class AddIndexChatIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :chat_id
  end
end
