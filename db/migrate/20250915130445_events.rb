class Events < ActiveRecord::Migration[8.0]
  def change
      drop_table :events_controllers
  end
end
