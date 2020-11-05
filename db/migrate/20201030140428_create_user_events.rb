class CreateUserEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_events do |t|
      t.belongs_to :user,  null: false, foreign_key: true
      t.belongs_to :event, null: false, foreign_key: true

      t.boolean :admin, null: false, default: false
      t.monetize :payment, amount: { null: true, default: 0 }
      t.monetize :debt, amount: { null: true, default: 0 }

      t.timestamps
    end
  end
end
