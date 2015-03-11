$('#add-membership').html ''
$('ul.memberships').append "<%= j render 'memberships/membership', 
 user: @membership_form.user, entity: @membership_form.entity %>"
