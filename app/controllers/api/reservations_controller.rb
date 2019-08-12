module Api
  class ReservationsController < ApplicationController
    before_action :load_shift
    before_action :load_reservation
    before_action :load_restaurant
    
    def create
      @reservation = Reservation.new reservation_params
      @reservation.shift = @shift
      
      if @reservation.save
        ReservationMailer.after_create(@reservation).deliver_now
        ReservationMailer.resume_after_create(@reservation).deliver_now
        render json: @reservation, status: :ok
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    end
    
    def update
      if @reservation.update(reservation_update_params)
        ReservationMailer.after_update(@reservation).deliver_now
        render json: @reservation, status: :ok
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    end
    
    def index
      @reservations = Reservation.for_restaurant(@restaurant)
      
      render json: @reservations.as_json(reservation_result)
    end
    
    private
    
    def reservation_update_params
      params.require(:reservation)
            .permit(:start_at,
                    :end_at,
                    :num_guests)
    end
    
    def reservation_result
      {
        only: [
          :num_guests,
          :start_at,
          :end_at,
        ],
        include: [
          {
            guest: {
              only: [
                :name
              ]
            },
            table: {
              only: [
                :name
              ]
            }
          }
        ] 
      }
    end
    
    def reservation_params
      params.require(:reservation)
            .permit(:start_at,
                    :end_at,
                    :num_guests,
                    :table_id,
                    :guest_id)
    end
    
    def load_restaurant
      return if params[:restaurant_id].blank?
      
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
    
    def load_reservation
      return if params[:id].blank?
      
      @reservation = @shift.reservations.find(params[:id])
    end
    
    def load_shift
      return if params[:shift_id].blank?
      
      @shift = Shift.find(params[:shift_id])
    end
  end
end