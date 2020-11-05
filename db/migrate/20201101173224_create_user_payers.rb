class CreateUserPayers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_payers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :payer, index: true

      t.monetize :debt, amount: { null: true, default: 0 }

      t.timestamps
    end
  end
end
