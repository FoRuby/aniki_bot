class DeleteSquadsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :squads
  end
end
