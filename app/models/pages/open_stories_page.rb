module Pages
  class OpenStoriesPage < StatusBoardPage
    def open_stories_component
      @open_stories_component ||= Components::OpenStoriesComponent.new
    end
  end
end
