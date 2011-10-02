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
      
      $.get("/api/channels", (data)->
        $("#channels").html(data.html)
        
      )

    channel = ->

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

    $("a.reload_index").pjax("#all")
    $("a.channel_link").pjax("#all")
    $("a.reload_index").pjax("#all")
)
