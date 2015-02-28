unless $('#add-mappings form').length
  $('#add-mappings').hide().append('<%= j render(:partial => "mappings/form", mapping: Mapping.new) %>').fadeIn('fast')
  $('#add-mapping-cancel').click ->
    $('#add-mappings').fadeOut 'fast', ->
      $(this).html ''