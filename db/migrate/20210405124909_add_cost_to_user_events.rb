class AddCostToUserEvents < ActiveRecord::Migration[6.1]
  def change
    add_monetize :user_events, :cost, { null: true, default: 0 }
  end
end
