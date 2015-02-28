$('#keywording-'+<%= @keywording.id %>).fadeOut(->
  $(this).remove()
  unless $('.keywordings .label').length
    $('.keywordings').append "<%= j render 'keywordings/no_keywordings', keywordable: @keywording %>"
)
