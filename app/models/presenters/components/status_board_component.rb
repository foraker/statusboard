module Presenters
  module Components
    class StatusBoardComponent < Base
      def partial
        @wrapped.class.name.underscore
      end
    end
  end
end
