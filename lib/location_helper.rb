# frozen_string_literal: true

module LocationHelper
  def find_nearest_location(origin_location:, available_locations:)
    return available_locations.last if available_locations.count == 1
    available_locations.sort_by { |location| distance_between(origin_location, location) }.first
  end

  private

  def distance_between(start_point, end_point)
    sum_of_squares = 0
    start_point.each_with_index do |start_point_coord, index|
      sum_of_squares += (start_point_coord - end_point[index])**2
    end

    Math.sqrt(sum_of_squares)
  end
end
