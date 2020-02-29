$(document).on('turbolinks:load', function(){
  $('.alert').delay(5000).slideUp(500, function(){
    $('.alert').alert('close');
  });
});