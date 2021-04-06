class DeleteDebtFromUserEvents < ActiveRecord::Migration[6.1]
  def change
    remove_monetize :user_events, :debt
  end
end
