module Pages
  module Components
    class ProjectOverviewComponent
      def projects
        Project.wrap(project_ids).sort_by(&:name)
      end

      def project_ids(options = Rails.application.secrets)
        options.pivotal_project_ids.split(", ")
      end
    end

    class Project < Struct.new(:project_id)
      def self.wrap(project_ids)
        project_ids.map { |project_id| new(project_id) }
      end

      def average_cycle_time
        @average_cycle_time ||= accepted_stories.average_duration_seconds
      end

      def name
        PivotalStory.for_project(project_id).first.project_name
      end

      def accepted_stories
        PivotalStory.for_project(project_id).accepted
      end
    end
  end
end
