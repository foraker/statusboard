module Presenters
  class PivotalProject < Base
    def cycle_time
      Duration.new(average_cycle_time).to_s
    end

    class Duration < Struct.new(:seconds)
      def to_s
        if days > 0
          "#{days} #{"day".pluralize(days)} and #{hours % 24} #{"hour".pluralize(hours)}"
        elsif hours > 0
          "#{hours} #{"hour".pluralize(hours)} and #{minutes % 60} #{"minute".pluralize(minutes)}"
        elsif minutes > 0
          "#{minutes} #{"minute".pluralize(minutes)} and #{seconds % 60} #{"second".pluralize(seconds)}"
        elsif seconds > 0
          "#{seconds} #{"second".pluralize(seconds)}"
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
    end
  end
end
