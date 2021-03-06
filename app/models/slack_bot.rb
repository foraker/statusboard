require 'slack'
require 'net/http'
require 'json'

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
        when "#{keyword} hi"
          hi data
        when "#{keyword} who needs thumbs"
          thumbs data
        when "#{keyword} party on"
          party_on data
        when "#{keyword} party off"
          party_off data
        when "#{keyword} help"
          commands data
        when /^#{keyword} insult/
          insult data
        when /^#{keyword}/
          method_missing data
        end
      end

      client.start
  end

  private

  def keyword
    "<@U073CAXCL>:"
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
                                                            \n- party on
                                                            \n- insult @user mild/moderate/extreme", as_user: true
  end

  def method_missing(data)
    Slack.chat_postMessage channel: data['channel'], text: "I don't take orders from you, <@#{data['user']}>", as_user: true
  end

  def insult(data)
    text = message data
    json = Net::HTTP.get URI("http://pleaseinsult.me/api?severity=#{severity(text)}")
    json = JSON.parse(json)
    Slack.chat_postMessage channel: data['channel'], text: "#{json['insult']} <#{target(data)}>", as_user: true
  end

  def message(data)
    data['text']
  end

  def target(data)
    /@\w{9}/.match(message(data), 13) ? /@\w{9}/.match(message(data), 13)[0] : "@#{data['user']}"
  end

  def severity(text)
    case text
      when /moderate/ then 'moderate'
      when /extreme/  then 'extreme'
      else                 'mild'
    end
  end

  def user_real_name(data)
    Slack.users_list['members'].select{|i| i['id']== data['user']}.first['real_name']
  end

  attr_accessor :client
end
