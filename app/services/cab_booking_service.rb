# frozen_string_literal: true

class CabBookingService
  include LocationHelper

  attr_reader :booked_cab

  def initialize(params)
    @user_location = params[:user_location]
    @preferred_color = params[:preferred_color]
  end

  def perform
    active_cabs = get_active_cabs
    available_cab_locations = active_cabs.pluck(:id, :location).to_h
    return unless available_cab_locations.present?

    @booked_cab = find_nearest_cab(available_cab_locations)
    booked_cab.mark_as_riding!
  end

  private

  def find_nearest_cab(available_cab_locations)
    nearest_location = find_nearest_location(origin_location: user_location, available_locations: available_cab_locations.values)
    cab_id = available_cab_locations.key(nearest_location)
    @booked_cab = Vehicle.find(cab_id)
  end

  def get_active_cabs
    active_cabs = Vehicle.cars.available
    preferred_color.present? ? active_cabs.where(color: preferred_color) : active_cabs
  end

  attr_reader :user_location, :preferred_color
end
