class Statusboard.AnnouncementMonitor
  constructor: ->
    setInterval(@checkForAnnouncements, 1000)
    @checkForAnnouncements()

  displayAnnouncements: (data) ->
    return unless data?

    @show("#{data.user}: #{data.words}")

  checkForAnnouncements: =>
    $.get '/announcements.json', (data) =>
      @displayAnnouncements(data)

  show: (text) ->
    $("#announcement").text(text)

    $("#announcement").slideDown ->
      setTimeout ->
        $("#announcement").slideUp()
      , 30000
