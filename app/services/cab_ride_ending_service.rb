# frozen_string_literal: true

class CabRideEndingService
  def initialize(params)
    @cab = Vehicle.find(params[:cab_id])
    @ending_location = params[:ending_location]
  end

  def perform
    cab.end_booking!(ending_location)
  end

  private

  attr_reader :cab, :ending_location
end
