booked_cab = @cab_booking_service.booked_cab

if booked_cab
  json.status 'success'
  json.message I18n.t('booking.ride_booking_successful')
  json.data do
    json.cab_id booked_cab.id.to_s
    json.cab_location booked_cab.location
  end
else
  json.status 'failure'
  json.message I18n.t('booking.no_rides_available')
end
