# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#mark_as_riding!' do
    it 'should update the status and last ride starting time' do
      vehicle = create(:vehicle, status: 'available')
      current_time = DateTime.now
      allow(DateTime).to receive_message_chain(:now).and_return(current_time)
      vehicle.mark_as_riding!
      expect(vehicle.status).to eq('riding')
      expect(vehicle.last_ride_started_at).to eq(current_time)
    end
  end

  describe '#end_booking!' do
    it 'should update the status and location' do
      vehicle = create(:vehicle, status: 'riding', location: [2, 2])
      vehicle.end_booking!([1, 1])
      expect(vehicle.status).to eq('available')
      expect(vehicle.location).to eq([1, 1])
    end
  end
end
