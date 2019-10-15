# frozen_string_literal: true

require 'rails_helper'
describe LocationHelper do
  describe '#find_nearest_location' do
    it 'should return the nearest location' do
      klass = Class.new { extend LocationHelper }
      locations = [[5, 5], [1, 1], [2, 3], [3, 2]]
      nearest_location = klass.find_nearest_location(origin_location: [0, 0], available_locations: locations)
      expect(nearest_location).to eq([1, 1])
    end
  end
end
