namespace :slackbot do

  path = Rails.root.join('tmp/pids/slackbot.pid').to_s

  task start: :environment do
    unless File.exist?(path)
      fork do
        File.write(path, Process.pid)
        SlackBot.new
      end
    else
      puts "Only one instance at a time!"
    end
  end

  task stop: :environment do
    if File.exist?(path)
      pid = File.read(path)
      File.delete(path)
      Process.kill("SIGHUP", pid.to_i)
    else
      puts "There is no instance of Slack Bot running"
    end
  end
end
