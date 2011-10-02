$(->
  if $("#controller").val() == "home"
    channel_loop = ->
      setTimeout(->
        name = $("#channel_name").text()
        if name != "" and name != undefined
          last_id = $("#channel_log span.body span.none")[0]
          if last_id == undefined
            $.get("/api/channel/"+encodeURIComponent(name), (data)->
              $("#channel_insert_before").after(data.html)
              channel_loop()
            ).error(-> channel_loop())
          else
            $.get("/api/channel/"+encodeURIComponent(name)+"?last_id="+last_id.innerText, (data)->
              $("#channel_insert_before").after(data.html)
              channel_loop()
            ).error(-> channel_loop())
        else
          channel_loop()
      , 500)

    index = ->
      $("title").text("Labyriarra")
      $.get("/api/channels", (data)->
        $("#channels").html(data.html)
        
      )

    channel = ->
      $("title").text("Labyriarra "+$("#channel_name").text())

    loaded = ()->
      console.log $("#action").val()
      switch $("#action").val()
        when "index"
          index()
        when "channel"
          channel()

    
    $("body")
      .bind('pjax:start', ->
      )
      .bind('pjax:end', ->
        loaded()
      )

    loaded()
    channel_loop()

    $("a.reload_index").pjax("#main")
    $("a.channel_link").pjax("#main")
    $("a.reload_index").pjax("#main")
)
