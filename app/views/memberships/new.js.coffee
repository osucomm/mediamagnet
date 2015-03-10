unless $('#add-membership form').length
  $('#add-membership').append("<%= j render(:partial => 'memberships/form', membership: @membership) %>").fadeIn 'fast'

  $('#add-membership select').chosen().change ->
    $(this).closest('form').submit()

  $('#add-membership-cancel').click ->
    $('#add-membership').fadeOut 'fast', ->
      $(this).html ''
