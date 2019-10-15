Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      controller :bookings do
        post 'book-cab', action: :book_cab
        post 'end-ride', action: :end_ride
      end
    end
  end
end
