class Statusboard.BathroomMonitor
  constructor: ->
    setInterval(@liveUpdate, 10000)
    $(@liveUpdate)

  liveUpdate: =>
    $.get 'api/bathroom_updates'

$ ->
  new Statusboard.BathroomMonitor
