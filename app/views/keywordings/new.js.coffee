unless $('#add-keywording form').length
  $('#add-keywording').hide().append("<%= j render(:partial => 'keywordings/form', keywording: @keywording) %>").fadeIn 'fast'
  $('#add-keywording select').chosen().change ->
    $(this).closest('form').submit()

  $('#add-keywording-cancel').click ->
    $('#add-keywording').fadeOut 'fast', ->
      $(this).html ''
