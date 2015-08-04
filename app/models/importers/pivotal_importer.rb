require 'net/https'
require 'multi_json'
require 'yaml'
require 'time'

module Importers
  class PivotalImporter

    def import(options = Rails.application.secrets)
      project_ids = options.pivotal_project_ids.split(", ")
      project_ids.each do |project_id|
        CycleTimeForAcceptedStories.new.run(project_id)
      end
    end

    class CycleTimeForAcceptedStories

      def run(project_id)
        stories = {}
        offset = 0
        limit = 100
        total = nil
        count = 0
        project_name = get("projects/#{project_id}/", "")['name']
        STDERR.print "#{project_name}: "

        begin
          activity_with_envelope = get("projects/#{project_id}/activity", "offset=#{offset}&envelope=true")
          activity_items = activity_with_envelope['data']
          total = activity_with_envelope['pagination']['total']

          activity_items.each do |activity|
            activity['changes'].each do |change_info|
              count+=1
              STDERR.print ". " if (count + 1) % 100 == 0
              if is_state_change(change_info)
                story_id = change_info['id']
                stories[story_id] ||= {}
                stories[story_id]['id'] ||= story_id

                if change_info['new_values']['current_state'] == 'started'
                  stories[story_id]['started_at'] = activity['occurred_at']
                elsif stories[story_id]['accepted_at'].nil? && change_info['new_values']['current_state'] == 'accepted'
                  stories[story_id]['accepted_at'] = activity['occurred_at']
                end
              end
            end
          end

          offset += activity_with_envelope['pagination']['limit']
        end while total > offset
        STDERR.puts ""

        stories.keys.each_slice(100) do |story_ids|
          search_results = get("projects/#{project_id}/search", "query=id:#{story_ids.join(',')}%20includedone:true")
          search_results['stories']['stories'].each do |story_hash|
            stories[story_hash['id']]['name'] = story_hash['name']
            stories[story_hash['id']]['story_type'] = story_hash['story_type']
          end
        end

        stories.values.select {|story_info| story_info['story_type'] == 'feature'}.each do |story|
          PivotalStory.where(story_id: story['id']).
          create_with(
            project_id:     project_id,
            project_name:   project_name,
            started_at:     story['started_at'],
            accepted_at:    story['accepted_at'] || nil,
            story_name:     story['name']
          ).first_or_create
        end
      end

      def is_state_change(change_info)
        change_info['kind'] == 'story' &&
          change_info['new_values'] &&
          change_info['new_values'].has_key?('current_state')
      end

      def get(url, query, options = Rails.application.secrets)
        token = options.pivotal_token
        tracker_host = 'https://www.pivotaltracker.com'

        request_header = {
          'X-TrackerToken' => token
        }

        uri_string = tracker_host + '/services/v5/' + url
        resource_uri = URI.parse(uri_string)
        http = Net::HTTP.new(resource_uri.host, resource_uri.port)
        http.use_ssl = tracker_host.start_with?('https')

        response = http.start do
          http.get(resource_uri.path + '?' + query, request_header)
        end

        MultiJson.load(response.body)
      end
    end
  end
end
