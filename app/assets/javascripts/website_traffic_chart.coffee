class Statusboard.WebsiteTrafficChart
  constructor: (options) ->
    @el = options.el
    @buildChart(options.data)

  buildChart: (chart) =>
    @el.highcharts
      title:
        text: chart.title
        x: -20
      subtitle:
        x: -20
      xAxis:
        categories: chart.categories
      yAxis:
        title: text: ' '
        plotLines: [ {
          value: 0
          width: 1
          color: '#808080'
        } ]
      legend:
        layout: 'vertical'
        align: 'right'
        verticalAlign: 'middle'
        borderWidth: 0
      series: chart.series
