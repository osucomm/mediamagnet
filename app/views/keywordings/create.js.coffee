$('#add-keywording').html ''
$('.keywordings').append("<%= j render 'keywordings/keywording', keywording: @keywording %>")
$('[data-toggle="tooltip"]').tooltip()
$('.no-keywords').hide()
