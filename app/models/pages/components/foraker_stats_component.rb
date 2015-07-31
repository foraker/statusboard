module Pages
  module Components
    class ForakerStatsComponent

      def chart(days, slice)
        @chart = Highcharts.new do |chart|
          chart.chart(renderTo: "graph-#{days}")
          chart.title(text: "Foraker.com Statistics (Past #{days} Days)", style: {:'font-size' => '30px'})
          chart.xAxis(categories: mydate(days, slice))
          chart.yAxis(title: ' ', min: 0)
          chart.series(
            [{name: 'Visitors',   yAxis: 0, type: 'line', data: categories("visitors", days, slice)},
             {name: 'Page Views', yAxis: 0, type: 'line', data: categories("pageviews", days, slice)},
             {name: 'Sessions',   yAxis: 0, type: 'line', data: categories("sessions", days, slice)}
            ])
          chart.legend(layout: 'vertical', align: 'right', verticalAlign: 'top', x: -10, y: 100, borderWidth: 0, itemStyle: {fontSize:'30px'})
          chart.tooltip(formatter: "function(){ return '<b>' + this.series.name + '</b><br/>' + this.x + ': ' + this.y; }")
        end
      end

      private

      def nodes(count)
        @nodes = WebsiteTrafficPoint.latest(count)
      end

      def categories(attribute, count, slice)
        data = nodes(count).map{|node| node.send(attribute)}
        array = []
        data.each_slice(slice) do |slice|
         array.push(slice.inject(:+))
        end
        array.pop
        return array
      end

      def mydate(count, slice)
        data = nodes(count)
        array = []
        (0..data.length-1).step(slice) do |slice|
          array.unshift data[slice].date.to_s
        end
        return array
      end
    end
  end
end
