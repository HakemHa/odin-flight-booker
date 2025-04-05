class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.map { |a| [ a.code, a.id ] }
    @available_dates = Flight.all.map { |f| [ f.start_date.strftime("%d/%m/%Y"), f.start_date.strftime("%d/%m/%Y") ] }
    @available_dates = @available_dates.sort do |a, b|
      if Time.parse(a[0]).to_i <= Time.parse(b[0]).to_i
        next -1
      else
        next 1
      end
    end.uniq
    if flight_params
      formatted_date = DateTime.parse(params["date"]).strftime("%Y-%m-%d")
      @flight_options = Flight.where(
        departure_id: params["departure_id"],
        arrival_id: params["arrival_id"]
        ).where("start_date LIKE ?", "%" + formatted_date + "%")
    else
      @flight_options = Flight.all
    end
  end

  private

  def flight_params
    params.key?("departure_id") && params.key?("arrival_id") && params.key?("date")
  end
end
