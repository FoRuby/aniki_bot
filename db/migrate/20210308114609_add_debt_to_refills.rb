class AddDebtToRefills < ActiveRecord::Migration[6.1]
  def change
    add_reference :refills, :debt, null: false, foreign_key: true
  end
end
