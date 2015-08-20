module Pages
  class RecentStoriesPage < StatusBoardPage
    def recent_stories_component
      @recent_stories_component ||= Components::RecentStoriesComponent.new
    end
  end
end
