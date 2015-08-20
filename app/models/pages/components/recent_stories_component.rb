module Pages
  module Components
    class RecentStoriesComponent
      def stories
        PivotalStory.recently_accepted
      end
    end
  end
end
