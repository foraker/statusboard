class Statusboard.BathroomMonitor
  constructor: ->
    setInterval(@liveUpdate, 10000)
    $(@liveUpdate)

  liveUpdate: =>
    $.ajax { url: 'api/bathroom_updates' }

$ ->
  new Statusboard.BathroomMonitor
