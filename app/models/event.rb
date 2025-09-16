class Event < ApplicationRecord
  belongs_to :user # Add this line 👈
  has_many :registrations, dependent: :destroy
  validates :event_name, :date, :location, :description, presence: true

  validates :event_name, length: { maximum: 100 }, uniqueness: { scope: :date, message: "already exists on this date" }
  validates :location, length: { maximum: 150 }
  validates :description, length: { minimum: 5, maximum: 500 }

  validate :date_cannot_be_in_the_past

  private

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "Please Choose Future Dates")
    end
  end
end
