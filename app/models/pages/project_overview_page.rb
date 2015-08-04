module Pages
  class ProjectOverviewPage < StatusBoardPage
    def project_overview_component
      @project_overview_component ||= Components::ProjectOverviewComponent.new
    end
  end
end
