# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('click', '#loginAndCreate input[type="submit"]', (event) ->
  event.preventDefault()
  $('#loginAndCreate .alert').addClass('Hidden')
  $(event.target).attr('disabled', 'disabled')
  $('#errorText').html('')
  $('#errorsList').html('')
  form = $(event.target).closest('form')
  $.ajax $(form).attr('action'),
    type: 'POST'
    dataType: 'JSON'
    data: $(form).serialize()
    error: (jqXHR, textStatus, errorThrown) ->
      $('#loginAndCreate .alert').removeClass('Hidden')
      err = '<p>There was an error on our server. Please contact us for help.</p><p><strong>Error:</strong> ' + errorThrown + '</p>'
      $('#errorText').html(err)
      $(event.target).removeAttr('disabled')
    success: (data, textStatus, jqXHR) ->
      if (data.success == true)
        window.location = '/account'
      else
        $('#loginAndCreate .alert').removeClass('Hidden')
        err = data.errors.reduce(((prev, curr, index, array) ->
          prev + '<li>' + curr + '</li>'
        ), '')
        $('#errorsList').html(err)
        $(event.target).removeAttr('disabled')
)

$(document).on('click', '#toggleCreateAccount', ->
  $('#errorText').html('')
  $('#errorsList').html('')
  $('#login_form').addClass('Hidden')
  $('#new_user').removeClass('Hidden')
  $('#userNames').slideDown()
  $('#toggleCreateAccount').addClass('Hidden')
  $('#toggleLogin').removeClass('Hidden')
)
$(document).on('click', '#toggleLogin', ->
  $('#errorText').html('')
  $('#errorsList').html('')
  $('#userNames').slideUp()
  setTimeout((->
    $('#new_user').addClass('Hidden')
    $('#login_form').removeClass('Hidden')
  ), 400)
  $('#toggleCreateAccount').removeClass('Hidden')
  $('#toggleLogin').addClass('Hidden')
)