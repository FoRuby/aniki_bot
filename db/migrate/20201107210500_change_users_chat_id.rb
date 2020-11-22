class ChangeUsersChatId < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :chat_id, :bigint, using: 'chat_id::bigint'
  end
end
