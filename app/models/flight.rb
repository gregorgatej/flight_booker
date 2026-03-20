class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  has_many :bookings, dependent: :destroy

  validates :start_datetime, :duration_minutes, :price_cents, presence: true
  validate :different_airports

  scope :ordered, -> { order(:start_datetime) }
  scope :on_date, ->(date) { where(start_datetime: date.all_day) }

  def self.search(departure_airport_id:, arrival_airport_id:, date:)
    where(
      departure_airport_id: departure_airport_id,
      arrival_airport_id: arrival_airport_id
    ).on_date(date).ordered
  end

  private
    def different_airports
      return if departure_airport_id != arrival_airport_id

      errors.add(:arrival_airport, "must be different from departure airport")
    end
end
