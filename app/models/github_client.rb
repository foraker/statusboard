class GithubClient
  def initialize(options = Rails.application.secrets)
    self.github = Github.new user: "foraker", oauth_token: options.github_oauth
  end

  def getRepos()
    repos = github.repos.list :org => 'foraker'
  end

  def getIssues()
    pulls = Array.new
    issues = github.issues.list(:org => 'foraker', :filter => 'all')
    issues.each do |pull|
      if pull["pull_request"] then
        comments = github.issues.comments.list(owner: 'foraker',
                                               repo: pull.repository.name,
                                               number: pull.number)
        thumbs = 0
        comments.each do |comment|
          thumbs += comment.body.scan(/:\+1:/).length
        end
        temp = PullRequest.new(pull.repository.name.capitalize,
                               pull.title,
                               pull.user.login,
                               pull.user.avatar_url,
                               thumbs,
                               pull.html_url)
        pulls.push(temp)
      end
    end
    return pulls
  end

  private

  attr_accessor :github
end

#This is a very Java way to do this. I bet there's a better Ruby way
class PullRequest
  def initialize(repo, title, author, avatar_url, thumbs, pull_url)
    @repo = repo
    @title = title
    @author = author
    @avatar_url = avatar_url
    @thumbs = thumbs
    @pull_url = pull_url
  end

  def getRepo
    return @repo
  end

  def getTitle
    return @title
  end

  def getAuthor
    return @author
  end

  def getAvatar
    return @avatar_url
  end

  def getThumbs
    return @thumbs
  end

  def getPullUrl
    return @pull_url
  end
end
