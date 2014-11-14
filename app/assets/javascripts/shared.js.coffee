ready = ->
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100%'

  $('.footable').footable()

$(document).ready(ready)
$(document).on('page:load', ready)
