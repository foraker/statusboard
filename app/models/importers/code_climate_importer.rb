module Importers
  class CodeClimateImporter
    module ApiToken
      def api_token
        Rails.application.secrets.code_climate_api_token
      end
    end

    def import
      projects.each(&:persist_score)
    end

    private

    def projects
      CodeClimateProjects.all
    end

    class CodeClimateProjects
      include ApiToken

      def self.all
        new.all
      end

      def all
        CodeClimateProject.wrap(api_response).select(&:relevant?)
      end

      private

      def api_response
        HTTParty.get('https://codeclimate.com/api/repos?api_token=' + api_token).parsed_response
      end
    end

    CodeClimateProject = Struct.new(:id, :url) do
      include ApiToken

      def self.wrap(raw_projects)
        raw_projects.map do |raw_response|
          new(raw_response['id'], raw_response['url'])
        end
      end

      def relevant?
        project.present?
      end

      def project
        @project ||= Project.with_repository(repo_name).first
      end

      def repo_name
        url.match(/foraker\/(.+)\.git/)[1]
      rescue
        nil
      end

      def persist_score
        return if project.code_climate_scores.latest.try(:score) == score

        project.code_climate_scores.create(score: score)
      end

      def score
        @score ||= HTTParty.get(
          "https://codeclimate.com/api/repos/#{id}?api_token=#{api_token}"
        ).parsed_response['last_snapshot']['gpa']
      rescue Exception => e
        puts id
        nil
      end
    end
  end
end
