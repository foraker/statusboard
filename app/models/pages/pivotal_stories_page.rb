module Pages
  class PivotalStoriesPage < StatusBoardPage
    def open_stories_component
      @open_stories_component ||= Components::OpenStoriesComponent.new
    end
  end
end
