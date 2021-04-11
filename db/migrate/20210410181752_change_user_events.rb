class ChangeUserEvents < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user_events, :cost_kopecks, true, nil
    change_column_null :user_events, :cost_currency, true, nil
  end
end
