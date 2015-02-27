ready = ->
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100%'

  $('.chosen-select.autosubmit').on 'change', ->
    $('#submit').click()

  $('.footable').footable()

$(document).ready(ready)
$(document).on('page:load', ready)



# Override Rails handling of confirmation dialog

$.rails.allowAction = (element) ->
  # Check that we have a confirmation message
  confirm = element.data('confirm')
  return true unless confirm

  # Get optional text
  message = if element.data('confirm-message') then element.data('confirm-message') else 'This action cannot be undone.'
  ok = if element.data('confirm-ok') then element.data('confirm-ok') else element.text()
  cancel = if element.data('confirm-cancel') then element.data('confirm-cancel') else 'Cancel'

  $link = element.clone()
    .removeAttr('class')
    .removeAttr('data-confirm')
    .addClass('btn').addClass('btn-danger')
    .html(ok)

  # Create the modal box with the message
  modal_html = """
                <div class="modal fade" id="myModal">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3>#{confirm}</h3>
                      </div>
                      <div class="modal-body">
                        <p>#{message}</p>
                      </div>
                      <div class="modal-footer">
                        <a data-dismiss="modal" class="btn">#{cancel}</a>
                      </div>
                    </div>
                  </div>
                </div>
               """
  $modal_html = $(modal_html)
  $modal_html.find('.modal-footer').append($link)
  $modal_html.modal()

  # Prevent the original link from working
  return false
