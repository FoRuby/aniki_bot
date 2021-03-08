class RenameDebtDebtToValue < ActiveRecord::Migration[6.1]
  def change
    rename_column :debts, :debt_kopecks, :value_kopecks
    rename_column :debts, :debt_currency, :value_currency
  end
end
