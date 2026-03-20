module FlightsHelper
  def search_params_present?
      params[:departure_airport_id].present? &&
      params[:arrival_airport_id].present? &&
      params[:date].present?
  end
end
