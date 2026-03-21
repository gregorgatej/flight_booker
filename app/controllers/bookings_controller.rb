class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight: @flight)

    params[:num_passengers].to_i.times do
      @booking.passengers.build
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @fligth = @booking.flight

    if @booking.save
      redirect_to @booking
    else
      render :new, status: unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private
    def booking_params
      params.require(:booking).permit(
        :flight_id,
        passengers_attributes: [ :name, :email ]
      )
    end
end
