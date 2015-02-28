unless $('#add-keywording form').length
  $('#add-keywording').append("<%= j render(:partial => 'keywordings/form', keywording: @keywording) %>")
  $('select').chosen()
