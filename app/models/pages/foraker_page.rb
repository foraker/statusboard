module Pages
  class ForakerPage < StatusBoardPage
    def foraker_stats_component
      @foraker_stats_component ||= Components::WebsiteStatsComponent.new
    end
  end
end
