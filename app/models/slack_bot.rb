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
          hi data
        when /^statusboard announce (.+)/
          announce data, Regexp.last_match[1]
        when /^statusboard marquee (.+)/
          marquee data, Regexp.last_match[1]
        when 'statusboard who needs thumbs'
          thumbs data
        when 'statusboard party on'
          party_on data
        when 'statusboard party off'
          party_off data
        when 'statusboard commands'
          commands data
        when /^statusboard/
          method_missing data
        end
      end

    Thread.new do
      client.start
    end

  end

  private

  def announce(data, words)
    create_announcement data, words
    Slack.chat_postMessage channel: '#general', text: "@channel #{user_real_name(data)}: #{words}", as_user: true, link_names: true
  end

  def marquee(data, words)
    create_announcement data, words
  end

  def thumbs(data)
    Slack.chat_postMessage channel: data['channel'], text: "hubot who needs thumbs", as_user: true
  end

  def hi(data)
    Slack.chat_postMessage channel: data['channel'], text: "Hi <@#{data['user']}>!", as_user: true
  end

  def party_on(data)
    Slack.chat_postMessage channel: data['channel'], text: "COMMENCING PARTY MODE", as_user: true
    system './outlet.sh'
  end

  def party_off(data)
    Slack.chat_postMessage channel: data['channel'], text: "BACK TO WORK YOU BUMS", as_user: true
    system './outlet.sh'
  end

  def commands(data)
    Slack.chat_postMessage channel: data['channel'], text: "You can do:
                                                            \n- hi
                                                            \n- marquee
                                                            \n- announce
                                                            \n- who needs thumbs
                                                            \n- party on", as_user: true
  end

  def method_missing(data)
    Slack.chat_postMessage channel: data['channel'], text: "I don't take orders from you, <@#{data['user']}>", as_user: true
  end

  def user_real_name(data)
    Slack.users_list['members'].select{|i| i['id']== data['user']}.first['real_name']
  end

  def create_announcement(data, words)
    Announcement.create(user: user_real_name(data).upcase, words: words.upcase)
  end

  attr_accessor :client
end
