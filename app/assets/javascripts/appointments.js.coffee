# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('body').on('click', '#savePallet', ->
  pallet = $('#pallet').val()
  $.ajax ('/contracts/' + $('#contractID').html() + '/pallet'),
    type: 'PATCH'
    dataType: 'json'
    data: { contract: { pallet: pallet } }
    success: (data, status, xhr) -> $('#savePalletResults').html((if data.success then 'Saved' else 'Error, try again'))
    error: (xhr, textStatus, err) -> $('#savePalletResults').html('Error: ' + textStatus)
)
$('body').on('click', '#saveTeam', ->
  team = $('#team').val()
  $.ajax ('/appointments/' + $('#appointmentID').html() + '/team'),
    type: 'PATCH'
    dataType: 'json'
    data: { appointment: { team: team } }
    success: (data, status, xhr) -> $('#saveTeamResults').html((if data.success then 'Saved' else 'Error, try again'))
    error: (xhr, textStatus, err) -> $('#saveTeamResults').html('Error: ' + textStatus)
)