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
        def initialize(options, config_path = Rails.root.join('config/graph_metrics.yml'))
          self.days    = options.fetch(:days)
          self.slice   = options.fetch(:slice)
          self.metrics = YAML.load_file(config_path).map { |config| OpenStruct.new(config) }
        end

        def to_json
          as_json.to_json
        end

        def as_json
          return unless nodes.present?

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
            Metric.new(metric.name, slice, nodes, metric.color).as_json
          end
        end

        def categories
          (1..nodes.length-2).step(slice).map do |slice|
            nodes[slice].date
          end.reverse
        end

        def nodes
          @nodes ||= WebsiteTrafficPoint.latest(days)
        end

        def title
          "Past #{days} Days"
        end

        class Metric < Struct.new(:metric, :slice, :nodes, :color)
          def as_json
            {
              name: name,
              data: data,
              color: color
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
