module Pages
  class ForakerPage < StatusBoardPage
    def foraker_stats_component
      @foraker_stats_component ||= Components::ForakerStatsComponent.new
    end
  end
end
