ready = ->  $.get('/api/update_channels') #チャンネルリストの更新

$(document).on('page:change', ready)
$(document).ready(ready)
