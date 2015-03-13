$('#add-keywording').html ''
$('.keywordings').append("<%= j render 'keywordings/keywording', keywording: @keywording, on_parent: false %>")
$('[data-toggle="tooltip"]').tooltip()
$('.no-keywords').hide()
