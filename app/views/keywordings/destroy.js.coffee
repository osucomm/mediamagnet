$('#keywording-'+<%= @keywording.id %>).fadeOut 'fast', ->
  $(this).remove()
  unless $('.keywordings .label').length
    $('.keywordings').append "<%= j render 'keywordings/no_keywordings', keywordable: @keywording %>"

$('.tooltip').fadeOut 'fast'
