$ ->
  @pageNo = switch window.location.hash.substr(1)
    when 'recent'              then 0
    when 'open'                then 1
    when 'summary'             then 2
    when 'twitter', 'weather'  then 3
    when 'pull', 'pulls', 'pr' then 4
    when 'analytics'           then 5
    else                       parseInt(window.location.hash.substr(1))-1

  if @pageNo > 0 then $('#carousel').carousel @pageNo
