# frozen_string_literal: true

require 'rails_helper'

describe CabBookingService do
  describe '#perform' do
    context 'when no cab matching the conditions are availabe' do
      context 'no active cars availabe' do
        it 'should not set the booked cab' do
          cab_booking_service = CabBookingService.new(user_location: [0, 0], preferred_color: nil)
          cab_booking_service.perform
          expect(cab_booking_service.booked_cab).to be(nil)
        end
      end

      context 'no active cars with desired color available' do
        it 'should not set the booked cab' do
          create(:vehicle, location: [1, 1], color: 'red', status: 'available')
          cab_booking_service = CabBookingService.new(user_location: [0, 0], preferred_color: 'pink')
          cab_booking_service.perform
          expect(cab_booking_service.booked_cab).to be(nil)
        end
      end
    end

    context 'when matching cars are available' do
      context 'when no color preference is required' do
        it 'should find the nearest cab available' do
          cab_to_be_booked = create(:vehicle, location: [1, 1], color: 'red', status: 'available')
          create(:vehicle, location: [2, 2], color: 'red', status: 'available')
          cab_booking_service = CabBookingService.new(user_location: [0, 0], preferred_color: nil)
          expected_nearest_location_params = { origin_location: [0, 0], available_locations: [[1, 1], [2, 2]] }
          allow(cab_booking_service).to receive(:find_nearest_location).with(expected_nearest_location_params).and_return([1, 1])
          cab_booking_service.perform
          expect(cab_booking_service.booked_cab.id).to eq(cab_to_be_booked.id)
        end
      end

      context 'when customer has a color preference' do
        it 'should find the nearest cab available' do
          create(:vehicle, location: [1, 1], color: 'red', status: 'available')
          cab_to_be_booked = create(:vehicle, location: [2, 2], color: 'pink', status: 'available')
          cab_booking_service = CabBookingService.new(user_location: [0, 0], preferred_color: 'pink')
          expected_nearest_location_params = { origin_location: [0, 0], available_locations: [[2, 2]] }
          allow(cab_booking_service).to receive(:find_nearest_location).with(expected_nearest_location_params).and_return([2, 2])
          cab_booking_service.perform
          expect(cab_booking_service.booked_cab.id).to eq(cab_to_be_booked.id)
        end
      end

      it 'should mark the car as riding' do
        create(:vehicle, location: [2, 2], color: 'pink', status: 'available')
        cab_booking_service = CabBookingService.new(user_location: [0, 0], preferred_color: 'pink')
        expected_nearest_location_params = { origin_location: [0, 0], available_locations: [[2, 2]] }
        allow(cab_booking_service).to receive(:find_nearest_location).with(expected_nearest_location_params).and_return([2, 2])
        expect_any_instance_of(Vehicle).to receive(:mark_as_riding!)
        cab_booking_service.perform
      end
    end
  end
end
