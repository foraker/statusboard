module Pages
  module Components
    class TwitterComponent
      def tweets
        @tweets ||= Tweet.latest(3)
      end
    end
  end
end
