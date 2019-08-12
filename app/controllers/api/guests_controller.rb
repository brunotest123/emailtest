module Api
  class GuestsController < ApplicationController
    
    def create
      @guest = Guest.new guest_params
      if @guest.save
        render json: @guest, status: :ok
      else
        render json: @guest.errors, status: :unprocessable_entity
      end
    end
    
    private
    
    def guest_params
      params.require(:guest)
            .permit(:name,
                    :email)
    end
  end
end