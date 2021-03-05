class ChangeDebtsColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :debts, :user_id, :creditor_id
    rename_column :debts, :payer_id, :borrower_id
    change_column_null :debts, :creditor_id, false
  end
end
