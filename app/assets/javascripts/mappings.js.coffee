# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#new_mapping").on("ajax:success", (e, data, status, xhr) ->
    console.log('sd')
    $("#new_article").append xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log('sd')
    $("#new_mapping").append "<p>ERROR</p>"
