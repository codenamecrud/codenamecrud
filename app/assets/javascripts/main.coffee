jQuery ->
  $('.alert.flash').delay(6000).slideUp()
  $('.alert.flash').delete

  $('[data-toggle="tooltip"]').tooltip()
