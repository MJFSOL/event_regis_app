class Registration < ApplicationRecord
  belongs_to :event

  validates :event, presence: true

  def self.to_csv
    attributes = %w[attendee_name attendee_email event_name]

    CSV.generate(headers: true) do |csv|
      csv << attributes.map { |attr| attr.titleize.gsub("_", " ") }

      all.each do |registration|
        csv << [
          registration.attendee_name,
          registration.attendee_email,
          registration.event.event_name
        ]
      end
    end
  end
end
