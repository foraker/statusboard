module Pages
  module Components
    class ProjectOverviewComponent
      def projects
        PivotalProject.with_id(project_ids).ordered_by_name
      end

      def project_ids(options = Rails.application.secrets)
        options.pivotal_project_ids.split(", ")
      end
    end
  end
end
