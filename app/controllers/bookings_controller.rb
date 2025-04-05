class BookingsController < ApplicationController
  def new
    @new_booking = Booking.new
    @flight = Flight.find(params["flight"]["flight_id"])
    @amount_of_passengers = params["flight"]["passengers"].to_i
    @amount_of_passengers.times { @new_booking.passengers.build }
  end

  def create
    @new_booking = Booking.new(flight_id: params["booking"]["flight_id"])
    if @new_booking.save
      params["booking"]["passengers_attributes"].each do |k, v|
        Passenger.create(
          name: v["name"],
          email: v["email"],
          booking_id: @new_booking.id
        )
      end
      redirect_to bookings_show_path, flash: { booking_id: @new_booking.id }
    else
      render :create
    end
  end

  def show
    p params
    @booking = Booking.find(flash["booking_id"])
    @flight = @booking.flight
    @passengers = @booking.passengers
  end
end
