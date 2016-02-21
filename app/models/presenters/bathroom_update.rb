module Presenters
  class BathroomUpdate < Frosting::BasePresenter
    def occupied_state
      occupied? ? "occupied" : "unoccupied"
    end
  end
end
