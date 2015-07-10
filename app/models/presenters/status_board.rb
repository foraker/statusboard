module Presenters
  class StatusBoard < Base
    def components
      super.map do |component|
        present(component, context: @context)
      end
    end
  end
end
