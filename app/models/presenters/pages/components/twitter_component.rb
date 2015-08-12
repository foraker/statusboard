module Presenters
  module Pages
    module Components
      class TwitterComponent < Base
        presents_collections :tweets
      end
    end
  end
end
