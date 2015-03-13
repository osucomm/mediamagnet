$('#mapping-'+<%= @mapping.id %>).fadeOut 'fast', ->
  $(this).remove()
  unless $('table.mappings tbody tr').length
    $('table.mappings tbody').append "<%= j render 'mappings/no_mappings' %>"

$('.tooltip').fadeOut 'fast'
