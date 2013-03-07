initial = ->
  $('.metro_link').click ->
    $node = $(this)
    $('iframe').attr src: $node.attr('path'), id: $node.attr('id')

size_loop = ->
  $('html,body').height($(window).height()*95/100)
  $('.right').width($('#contents').width() - 20 - $('.left').width())
  $('#contents').height($('body').height() - $('header').height() - 20)
  setTimeout(size_loop, 200)

unread_loop = ->
  setTimeout ->
    $.get("/api/update_channels").success (datas)->
      $.each datas.data, (id, data)->
        if data.u
          $("a##{id}").addClass('unread_channel').text("#{data.name}(#{data.u})")
        else
          $("a##{id}").removeClass('unread_channel').text("#{data.name}")
      unread_loop()
  ,2000
  

$ ->
  $('#refresh_channel').click -> $.get('/api/update_channels').success (data)->
    $('#channels').html(data.pc)
    initial()
  initial()
  size_loop()
  unread_loop()
