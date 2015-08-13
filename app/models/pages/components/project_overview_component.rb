module Pages
  module Components
    class ProjectOverviewComponent
      def projects
        Project.ordered_by_name
      end
    end
  end
end
