module Presenters
  module Pages
    class HeaderPage < PagePresenter
      presents :github_component, :weather_component
    end
  end
end
