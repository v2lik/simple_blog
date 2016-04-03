$(document).ready(function() {
  $('.show-child-form').click(function(event) {
    event.preventDefault();
    $(this).closest('.row').next('.row').find('form').fadeIn();
  });
});
