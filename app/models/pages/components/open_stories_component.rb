module Pages
  module Components
    class OpenStoriesComponent
      def projects
        Project.ordered_by_name
      end

      def stories
        PivotalStory.in_progress
      end
    end
  end
end
