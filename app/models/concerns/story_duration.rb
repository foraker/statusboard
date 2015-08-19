include ActionView::Helpers::TextHelper

module StoryDuration
  def duration_in_words(seconds)
    Duration.new(seconds).to_s
  end

  class Duration < Struct.new(:seconds)
    def to_s
      if months > 0
        "#{pluralize months, 'month'} and #{pluralize days%30, 'day'}"
      elsif days > 0
        "#{pluralize days, 'day'} and #{pluralize hours%24, 'hour'}"
      elsif hours > 0
        "#{pluralize hours, 'hour'} and #{pluralize minutes%60, 'minute'}"
      elsif minutes > 0
        "#{pluralize minutes, 'minute'} and #{pluralize seconds%60, 'seconds'}"
      elsif seconds > 0
        "#{pluralize seconds, 'second'}"
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
