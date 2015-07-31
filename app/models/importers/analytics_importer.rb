require 'google/api_client'
require 'date'

module Importers
  class AnalyticsImporter
    def initialize
      @client  = Google::APIClient.new(application_name: ENV['GA_APP_NAME'])
      key_file = File.join('config/analytics', ENV['GA_KEY_FILE_NAME'])
      key      = Google::APIClient::PKCS12.load_key(key_file, 'notasecret')
      service_account = Google::APIClient::JWTAsserter.new(
        ENV['GA_SERVICE_ACCOUNT_EMAIL'],
        'https://www.googleapis.com/auth/analytics.readonly',
        key)
      @client.authorization = service_account.authorize
      @analytics = @client.discovered_api('analytics', 'v3')
    end

    def import
      start_date = 1.year.ago.to_date.strftime("%Y-%m-%d")
      end_date = Date.today.strftime("%Y-%m-%d")
      results = @client.execute(api_method: @analytics.data.ga.get, parameters: {
        ids:             "ga:" + ENV['GA_VIEW_ID'],
        :'start-date' => start_date,
        :'end-date'   => end_date,
        metrics:         "ga:visitors,ga:pageviews,ga:sessions",
        dimensions:      "ga:year,ga:month,ga:day",
        sort:            "ga:year,ga:month,ga:day"
      })
      unless results.error?
        storeResults(results.data)
      else
        puts results.error_message
        return {}
      end
    end

    def storeResults(results)
      results.rows.each do |result|
        node = WebsiteTrafficPoint.where(date: date(result)).first_or_create
        node.update_attributes(params(result))
        node.save
      end
    end

    def params(result)
      {
        date:      date(result),
        visitors:  result[3],
        pageviews: result[4],
        sessions:  result[5]
      }
    end

    def date(result)
      Date.new(result[0].to_i, result[1].to_i, result[2].to_i)
    end
  end
end
