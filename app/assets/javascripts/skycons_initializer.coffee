class Statusboard.SkyconInitializer
  constructor: ->
    for color in @_colors()
      @_initializeSkycons(color)

  _initializeSkycons: (color) ->
    skycons = new Skycons('color': color)

    for el in document.getElementsByClassName("#{color}-skycon")
      skycons.set el, el.dataset.weather

    skycons.play()

  _colors: ->
    [
      'white',
      'black'
    ]

$ ->
  new Statusboard.SkyconInitializer
