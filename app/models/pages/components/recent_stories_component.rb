module Pages
  module Components
    class RecentStoriesComponent
      def stories
        PivotalStory.recently_accepted.limit(10)
      end
    end
  end
end
