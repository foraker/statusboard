module PullRequests
  def approved_pull_requests
    pull_requests.approved
  end

  def unapproved_pull_requests
    pull_requests.unapproved
  end
end
