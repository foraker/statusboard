module Components
  class GithubComponent
    def tweets
      Tweet.latest(3)
    end
  end
end
