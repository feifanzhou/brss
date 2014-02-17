$ -> (
  mt = $(window).height() - 430
  $('#learnMore').css('margin-top', mt + 'px')
  setTimeout(( ->
    $('#learnMore').css('opacity', 1)
    $('#sidebar').css('left', '0px')
    $('#container').css('margin-left', '180px')
  ), 250)
)