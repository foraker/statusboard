module PullRequests
  def approved_pull_requests
    pull_requests.active.approved
  end

  def unapproved_pull_requests
    pull_requests.active.unapproved
  end
end
