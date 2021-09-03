class RemoveLocationFromTrips < ActiveRecord::Migration[6.1]
  def change
    remove_column :trips, :location, :string
  end
end
