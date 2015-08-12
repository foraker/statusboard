module Pages
  module Components
    class ProjectOverviewComponent
      def projects
        PivotalProject.select{|project| project_ids.include?(project.pivotal_id.to_s)}.sort_by(&:name)
      end

      def project_ids(options = Rails.application.secrets)
        options.pivotal_project_ids.split(", ")
      end
    end
  end
end
