module Presenters
  module Pages
    class PagePresenter < Base
      def partial
        @wrapped.class.name.underscore
      end
    end
  end
end
