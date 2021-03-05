class DeleteUserSquadsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :user_squads
  end
end
