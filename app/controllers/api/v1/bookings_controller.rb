# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      def book_cab
        @cab_booking_service = CabBookingService.new(permit_booking_params)
        @cab_booking_service.perform
      end

      def end_ride
        CabRideEndingService.new(permit_ride_ending_params).perform
      end

      private

      def permit_booking_params
        params.permit(:preferred_color, user_location: [])
      end

      def permit_ride_ending_params
        params.permit(:cab_id, ending_location: [])
      end
    end
  end
end
