class StatusBoard
  def pages
    [
      general_page,
      pull_requests_page
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
end
