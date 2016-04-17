module Api
  class BathroomUpdatesController < ApplicationController
    def index
      @room_1 = present bathroom_1 if bathroom_1
      @room_2 = present bathroom_2 if bathroom_2

      respond_to do |format|
        format.js
      end
    end

    def create
      @bathroom_update = BathroomUpdate.new(bathroom_update_params)

      @bathroom_update.save if @bathroom_update.valid?
      render nothing: true
    end

    private

    def bathroom_1
      BathroomUpdate.by_room(1).latest
    end

    def bathroom_2
      BathroomUpdate.by_room(2).latest
    end

    def bathroom_update_params
      params.require(:bathroom_update).permit(:occupied, :room)
    end
  end
end
