class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.integer :owner_id

      t.timestamps
    end
  end
end
