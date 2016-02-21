module Api
  class BathroomUpdatesController < ApplicationController
    def index
      @room_1 = present BathroomUpdate.by_room(1).latest
      @room_2 = present BathroomUpdate.by_room(2).latest

      respond_to do |format|
        format.js
      end
    end

    def create
      @bathroom_update = BathroomUpdate.new(bathroom_update_params)

      @bathroom_update.save if @bathroom_update.valid?
      render nothing: true
    end

    def bathroom_update_params
      params.require(:bathroom_update).permit(:occupied, :room)
    end
  end
end
