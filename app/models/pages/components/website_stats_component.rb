module Pages
  module Components
    class WebsiteStatsComponent

      def chart_month
        Chart.new(days: 30, slice: 1)
      end

      def chart_year
        Chart.new(days: 365, slice: 7)
      end

      class Chart
        def initialize(options)
          self.days    = options.fetch(:days)
          self.slice   = options.fetch(:slice)
          self.metrics = options.fetch(:metrics, ['visitors', 'pageviews', 'sessions'])
        end

        def to_json
          as_json.to_json
        end

        def as_json
          {
            title:      title,
            categories: categories,
            series:     series
          }
        end

        private

        attr_accessor :days, :slice, :metrics

        def series
          metrics.map do |metric|
            Metric.new(metric, slice, nodes).as_json
          end
        end

        def categories
          (1..nodes.length-2).step(slice).map do |slice|
            nodes[slice].date.to_s
          end.reverse
        end

        def nodes
          @nodes ||= WebsiteTrafficPoint.latest(days)
        end

        def title
          "Foraker.com Statistics (Past #{days} Days)"
        end

        class Metric < Struct.new(:metric, :slice, :nodes)
          def as_json
            {
              name: name,
              data: data
            }
          end

          private

          def name
            metric.titleize
          end

          def data
            data = metric_data_by_slice[1...-1].reverse
          end

          def metric_data_by_slice
            metric_data.each_slice(slice).map do |slice|
             slice.inject(:+)
            end
          end

          def metric_data
            nodes.map { |node| node.send(metric) }
          end
        end
      end
    end
  end
end
