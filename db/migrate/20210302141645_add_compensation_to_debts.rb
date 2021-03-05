class AddCompensationToDebts < ActiveRecord::Migration[6.1]
  def change
    add_column :debts, :is_compensation, :boolean, default: false
  end
end
