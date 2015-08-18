module StoryDuration

  def duration_in_words(seconds)
    Duration.new(seconds).to_s
  end

  class Duration < Struct.new(:seconds)
    def to_s
      if months > 0
        "#{months} months and #{days % 30} days"
      elsif days > 0
        "#{days} days and #{hours % 24} hours"
      elsif hours > 0
        "#{hours} hours and #{minutes % 60} minutes"
      elsif minutes > 0
        "#{minutes} minutes and #{seconds % 60} seconds"
      elsif seconds > 0
        "#{seconds} seconds"
      elsif seconds == 0
        "No stories accepted"
      end
    end

    def minutes
      seconds / 60
    end

    def hours
      minutes / 60
    end

    def days
      hours / 24
    end

    def months
      days / 30
    end
  end

end
