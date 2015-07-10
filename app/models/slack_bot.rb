require "slack"

class SlackBot
  def initialize(options = Rails.application.secrets)
    Slack.configure do |config|
      config.token = options.lita_token
    end
    auth = Slack.auth_test

    client = Slack.realtime

    client.on :hello do
      # Slack successfull connected ...
      #logger.info 'Successfully connected.'
    end

    client.on :message do |data|
      case data['text']
        when 'statusboard hi'
          Slack.chat_postMessage channel: data['channel'], text: "Hi <@#{data['user']}>!", as_user: true
        when 'statusboard who needs thumbs'
          Slack.chat_postMessage channel: data['channel'], text: "hubot who needs thumbs", as_user: true
        when 'statusboard lamp on'
          Slack.chat_postMessage channel: data['channel'], text: "Turning lamp on...", as_user: true
          system './outlet.sh'
        when 'statusboard lamp off'
          Slack.chat_postMessage channel: data['channel'], text: "Turning lamp off...", as_user: true
          system './outlet.sh'
        when /^statusboard/
          Slack.chat_postMessage channel: data['channel'], text: "I don't take orders from you, <@#{data['user']}>", as_user: true
          #render partial: slack, locals: {message: data['text']}
          #javascript_include_tag 'slack'
        end
      end
    #system "nohup client.start &"

    Thread.new do
      client.start
    end
  end

  attr_accessor :client
end
