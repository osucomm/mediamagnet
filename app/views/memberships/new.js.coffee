$('#add-membership').append("<%= j render(:partial => 'memberships/form', membership: @membership) %>")
$('select').chosen()
