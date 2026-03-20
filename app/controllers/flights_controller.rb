class FlightsController < ApplicationController
  def index
    @airports = Airport.order(:code)
    @flight_dates = Flight.ordered.map { |flight| flight.start_datetime.to_date }.uniq

    @matching_flights = []

    return unless search_params_present?

    date = Date.parse(params[:date])

    @matching_flights = Flight.search(
      departure_airport_id: params[:departure_airport_id],
      arrival_airport_id: params[:arrival_airport_id],
      date: date
    )
  end

  private
    def search_params_present?
      params[:departure_airport_id].present? &&
      params[:arrival_airport_id].present? &&
      params[:date].present?
    end
end
