$(->
  is_mobile = ->
    user_agent = navigator.userAgent
    user_agent.indexOf('iPhone') > -1 or user_agent.indexOf('iPad') > -1 or user_agent.indexOf('Windows Phone') > -1
  
  if $("#controller").val() == "home"
    initialize_index_mobile = ->
      $(".reload_index").removeAttr("href")
      $(".channel_link").removeAttr("href")
      $(".channel_link").click(-> open_channel($(this).text()))
      localStorage["location"] = "index"
    initialize_channel_mobile = ->
      $(".reload_index").removeAttr("href")
      $(".channel_link").removeAttr("href")
      $(".reload_index").click(-> open_index())
      localStorage["location"] = "channel"
      localStorage["channel"] = $("#channel_name").text()

    open_channel = (name)->
      $.get "/home/channel/"+encodeURIComponent(name)+"?mobile_xhr=true", (data)->
        $("#main").html(data)
        $.get "/api/channels", (data)->
          $("#channels").html data.html
          initialize_channel_mobile()

    open_index = ->
      $.get "/home/index?mobile_xhr=true", (data)->
        $("#main").html data
        index()
    unless is_mobile()
      $("a.reload_index").pjax("#main")
      $("a.channel_link").pjax("#main")
      $("body").bind('pjax:start', ->).bind('pjax:end', -> loaded())

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
      , 500)

    index = ->
      $("title").text "Labyriarra"
      $.get "/api/channels", (data)->
        $("#channels").html data.html
        initialize_index_mobile() if is_mobile()

    channel = ->
      $("title").text("Labyriarra "+$("#channel_name").text())

    loaded = ()->
      switch $("#action").val()
        when "index"
          index()
        when "channel"
          channel()

    loaded()
    channel_loop()

    if is_mobile()
      switch localStorage["location"]
        when "channel"
          open_channel(localStorage["channel"])
)
