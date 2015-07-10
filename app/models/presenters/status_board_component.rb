module Presenters
  class StatusBoardComponent < Base
    def partial
      @wrapped.class.name.underscore
    end
  end
end
