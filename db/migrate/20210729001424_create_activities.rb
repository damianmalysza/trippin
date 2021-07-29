class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.float :cost
      t.integer :trip_id
      t.datetime :date

      t.timestamps
    end
  end
end
