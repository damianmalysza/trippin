class CreateUsertrips < ActiveRecord::Migration[6.1]
  def change
    create_table :user_trips do |t|
      t.integer :trip_id
      t.integer :user_id

      t.timestamps
    end
  end
end
