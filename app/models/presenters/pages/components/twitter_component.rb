module Presenters
  module Pages
    module Components
      class TwitterComponent < Base
        def tweets
          present_collection super
        end
      end
    end
  end
end
