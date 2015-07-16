class Statusboard.Clock
  constructor: (el) ->
    @el = el
    setInterval(@liveUpdate, 1000)

  liveUpdate: =>
    @el.html(moment().format('h:mm:ss'))

$ ->
  new Statusboard.Clock($("#header-time"))
