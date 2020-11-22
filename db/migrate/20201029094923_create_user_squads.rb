class CreateUserSquads < ActiveRecord::Migration[6.0]
  def change
    create_table :user_squads do |t|
      t.belongs_to :user,  null: false, foreign_key: true
      t.belongs_to :squad, null: false, foreign_key: true

      t.boolean :admin, null: false, default: false

      t.timestamps
    end
  end
end
