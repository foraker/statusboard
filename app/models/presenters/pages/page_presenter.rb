module Presenters
  module Pages
    class PagePresenter < Base
      def self.presents *components
        components.each do |component|
          define_method(component) do
            present super()
          end
        end
      end

      def partial
        @wrapped.class.name.underscore
      end
    end
  end
end
