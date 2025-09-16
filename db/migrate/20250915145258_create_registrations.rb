class CreateRegistrations < ActiveRecord::Migration[8.0]
  def change
    create_table :registrations do |t|
      t.references :event, null: false, foreign_key: true
      t.string :attendee_name
      t.string :attendee_email

      t.timestamps
    end
  end
end
