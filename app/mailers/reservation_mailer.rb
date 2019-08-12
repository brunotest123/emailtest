class ReservationMailer < ApplicationMailer
  def after_create(reservation)
    @reservation = reservation
    
    mail to: @reservation.guest.email, subject: "New reservation ##{@reservation.id}"
  end
  
  def resume_after_create(reservation)
    @reservation = reservation
    
    mail to: @reservation.shift.restaurant.email, subject: "New reservation ##{@reservation.id}"
  end
  
  def after_update(reservation)
    @reservation = reservation
    
    mail to: [@reservation.guest.email, @reservation.shift.restaurant.email], subject: "Update reservation ##{@reservation.id}"
  end
end