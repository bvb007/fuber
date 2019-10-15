# frozen_string_literal: true

class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :color, type: String
  field :location, type: Array
  field :status, type: String, default: 'inactive'
  field :type, type: String, default: 'car'
  field :last_ride_started_at, type: DateTime

  VEHICLE_STATUS = %w[available riding inactive].freeze

  validates_inclusion_of :status, in: VEHICLE_STATUS
  scope :cars, -> { where(type: 'car') }
  scope :available, -> { where(status: 'available') }

  def mark_as_riding!
    self.status = 'riding'
    self.last_ride_started_at = DateTime.now
    save!
  end

  def end_booking!(ending_location)
    self.status = 'available'
    self.location = ending_location
    save!
  end
end
