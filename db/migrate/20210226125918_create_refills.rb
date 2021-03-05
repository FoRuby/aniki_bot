class CreateRefills < ActiveRecord::Migration[6.1]
  def change
    create_table :refills do |t|
      t.references :from_user, index: true, null: false
      t.references :to_user, index: true, null: false
      t.string :status, null: false

      t.monetize :value, amount: { null: true, default: 0 }

      t.timestamps
    end
  end
end
