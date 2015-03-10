unless $('#add-mappings form').length
  $('#add-mappings').hide().append('<%= j render(:partial => "mappings/form", mapping: Mapping.new) %>')

  $('#add-mappings select').change ->
    $(this).closest('form').submit()
  $('#add-mappings .keyword-select').hide()

  $('#add-mapping-cancel').click ->
    $('#add-mappings').fadeOut 'fast', ->
      $(this).html ''

  $('#mapping_tag_text').on 'change keyup paste', ->
    console.log $(this).val()
    $('.mapping-keyword-label').text('"'+$(this).val()+'"')
    $('#add-mappings .keyword-select').fadeIn()
    $('#add-mappings select').chosen()

  $('#add-mappings').fadeIn('fast')