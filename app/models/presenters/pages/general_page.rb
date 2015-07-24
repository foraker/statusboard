module Presenters
  module Pages
    class GeneralPage < PagePresenter
      presents :twitter_component, :weather_component
    end
  end
end
