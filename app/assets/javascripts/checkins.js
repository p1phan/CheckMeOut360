$(document).ready(function() {
  /* setting checkin block heights */
  resize_block();
  $(window).resize(function() {
    resize_block();
  });
});

function resize_block() {
  $('.center_block').each(function(index, obj) {
    var mini = $(obj).children('.mini-hero-unit');
    var sub = $(obj).children('.sub-hero-unit');
    $(mini).height(sub.height());
  });
}