# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
airport_codes = [ "ATL", "DXB", "DFW", "LHR", "HND", "DEN", "IST", "LAX", "ORD", "DEL", "CDG", "CAN", "JFK", "AMS", "MAD", "FRA", "SIN", "MCO", "LAS", "ICN", "PVG", "CLT", "PEK", "SZX", "MIA", "BKK", "BOM", "SEA", "SFO", "BCN" ]
airports = []
airport_codes.each do |code|
  airports.push(Airport.create!(code: code))
end
flight_amount = 30*30
flight_amount.times do
  departure = airports[Random.rand(airports.length)]
  arrival = airports[Random.rand(airports.length)]
  start_date = Time.at(DateTime.now().to_time.to_i + Random.rand(31536000)).to_datetime
  duration = 30 + Random.rand(1441 - 30)
  Flight.create!(
    departure_id: departure.id,
    arrival_id: arrival.id,
    start_date: start_date,
    duration: duration
    )
end
