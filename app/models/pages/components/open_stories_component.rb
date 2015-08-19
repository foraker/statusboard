module Pages
  module Components
    class OpenStoriesComponent
      def stories
        PivotalStory.in_progress
      end
    end
  end
end
