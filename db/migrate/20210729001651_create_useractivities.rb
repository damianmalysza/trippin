class CreateUseractivities < ActiveRecord::Migration[6.1]
  def change
    create_table :user_activities do |t|
      t.integer :user_id
      t.integer :activity_id
      t.boolean :activity_paid

      t.timestamps
    end
  end
end
