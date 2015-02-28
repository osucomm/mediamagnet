unless $('#add-mappings form').length
  $('#add-mappings').append('<%= j render(:partial => "mappings/form", mapping: Mapping.new) %>')
