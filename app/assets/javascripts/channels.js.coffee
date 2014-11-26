# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$ ->
  $('.hidden').hide

$(document).on 'click', '#add-contact', (event) ->
  this.preventDefault
  $(this).hide()
  $('fieldset.contact').first().removeClass('hidden').slideDown()
