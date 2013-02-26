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
      last_id = $(".log_id")[0]
      if last_id == undefined
        $.get("/api/channel/"+encodeURIComponent(name), (data)->
          $("#channel_insert_before").after(data.html)
          count_chat()
          channel_loop()
        ).error(-> channel_loop())
      else
        $.get("/api/channel/"+encodeURIComponent(name)+"?last_id="+last_id.innerText, (data)->
          $("#channel_insert_before").after(data.html)
          count_chat()
          channel_loop()
        ).error(-> channel_loop())
    else
      channel_loop()
  , 2000)
$ ->
  channel_loop()
