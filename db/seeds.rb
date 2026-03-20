# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
codes = %w[SFO NYC LAX ORD ATL DFW]
airports = codes.map { |code| Airport.create!(code: code) }

airport_by_code = airports.index_by(&:code)

dates = [
  Date.today,
  Date.today + 1,
  Date.today + 2,
  Date.today + 3
]

routes = [
  [ "SFO", "NYC" ],
  [ "NYC", "LAX" ],
  [ "LAX", "ORD" ],
  [ "ATL", "DFW" ],
  [ "DFW", "SFO" ],
  [ "ORD", "ATL" ],
  [ "SFO", "LAX" ],
  [ "NYC", "ATL" ]
]

dates.each do |date|
  routes.each_with_index do |(from, to), index|
    Flight.create!(
      departure_airport: airport_by_code[from],
      arrival_airport: airport_by_code[to],
      start_datetime: date.to_datetime + (8 + index).hours,
      duration_minutes: [ 90, 120, 150, 180, 210 ].sample,
      price_cents: [ 12000, 15000, 18000, 22000 ].sample
    )
  end
end
