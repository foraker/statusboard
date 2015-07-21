module Components
  class TwitterComponent
    def tweets
      Tweet.latest(3)
    end
  end
end
