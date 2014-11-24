$('#add-mappings').html ''
$('.mappings > tbody').append "<%= j render 'mappings/mapping_row', 
mappable: @mapping.mappable, mapping: @mapping %>"
