class AddLocationToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :location, :string
  end
end
