module Presenters
  class StatusBoard < Base
    def pages
      super.map do |page|
        present(page, context: @context)
      end
    end
  end
end
