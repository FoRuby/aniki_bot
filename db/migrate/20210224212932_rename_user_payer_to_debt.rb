class RenameUserPayerToDebt < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_payers, :debts
  end
end
