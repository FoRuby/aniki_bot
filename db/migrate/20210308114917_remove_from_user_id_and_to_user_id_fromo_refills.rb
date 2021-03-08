class RemoveFromUserIdAndToUserIdFromoRefills < ActiveRecord::Migration[6.1]
  def change
    remove_column :refills, :from_user_id
    remove_column :refills, :to_user_id
  end
end
