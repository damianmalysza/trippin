class CreateUsertrips < ActiveRecord::Migration[6.1]
  def change
    create_table :usertrips do |t|
      t.integer :trip_id
      t.integer :user_id

      t.timestamps
    end
  end
end
