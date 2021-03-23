class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.text :message
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
