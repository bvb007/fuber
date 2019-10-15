# frozen_string_literal: true

require 'rails_helper'

describe CabRideEndingService do
  describe '#perform' do
    it 'should call end_booking for the cab' do
      cab = create(:vehicle, status: 'riding')
      ending_service_obj = described_class.new(cab_id: cab.id.to_s, ending_location: [1, 1])
      expect(ending_service_obj.send(:cab)).to receive(:end_booking!).exactly(1).times
      ending_service_obj.perform
    end
  end
end
