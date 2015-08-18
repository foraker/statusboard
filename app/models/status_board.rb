class StatusBoard
  def pages
    [
      pivotal_stories_page,
      project_overview_page,
      general_page,
      pull_requests_page,
      foraker_page
    ]
  end

  def header
    @header ||= Pages::HeaderPage.new
  end

  private

  def parser_component
    @parser_component ||= UrlParser.new
  end

  def general_page
    @general ||= Pages::GeneralPage.new
  end

  def pull_requests_page
    @pull_requests ||= Pages::PullRequestsPage.new
  end

  def foraker_page
    @foraker ||= Pages::ForakerPage.new
  end

  def project_overview_page
    @project_overview ||= Pages::ProjectOverviewPage.new
  end

  def pivotal_stories_page
    @pivotal_stories ||= Pages::PivotalStoriesPage.new
  end
end
