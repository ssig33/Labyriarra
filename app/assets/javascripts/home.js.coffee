count_chat = ->
  count = 0
  $.each $("span.body"), ->
    count += 1
    if count > 200
      $(this).remove()

channel_loop = ->
  setTimeout(->
    name = $("#channel_name").text()
    if name != "" and name != undefined
      $last_id = $(".log_id")
      if $last_id.get(0) == undefined
        $.get("/channel/#{encodeURIComponent(name)}", update: true, (data)->
          $("#channel_insert_before").after(data.html)
          count_chat()
          channel_loop()
        ).error(-> channel_loop())
      else
        $.get("/channel/#{encodeURIComponent(name)}", last_id: $last_id.first().text(), update: true, (data)->
          $("#channel_insert_before").after(data.html)
          count_chat()
          channel_loop()
        ).error(-> channel_loop())
    else
      channel_loop()
  , 2000)
$ ->
  $.get('/api/update_channels')
  channel_loop()
