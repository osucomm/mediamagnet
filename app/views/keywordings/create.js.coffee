$('#add-keywording').html ''
$('.keywordings').append "<%= j render 'keywordings/keywording', 
 keywording: @keywording %>"
$('.no-keywords').hide()
