$('#add-mappings').append("<%= j render(:partial => 'mappings/form', mapping: Mapping.new) %>")
console.log('yes')