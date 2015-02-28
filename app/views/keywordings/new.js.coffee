unless $('#add-keywording form').length
  $('#add-keywording').hide().append("<%= j render(:partial => 'keywordings/form', keywording: @keywording) %>").fadeIn 'fast'
  $('select').chosen()
  $('#add-keywording-cancel').click ->
    $('#add-keywording').fadeOut 'fast', ->
      $(this).html ''
