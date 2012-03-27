CHECK_ME_OUT_360.checkins = {
  index_action: function() {
    /* setting checkin block heights */
    resize_block('.mini-hero-unit', '.sub-hero-unit');
    $(window).resize(function() {
      resize_block('.mini-hero-unit', '.sub-hero-unit');
    });
  },
  show_action: function() {CHECK_ME_OUT_360.checkins.index_action(); }
}

function resize_block(small, big) {
  console.log(small);
  console.log(big);
  
  $('.center_block').each(function(index, obj) {
    var mini = $(obj).children(small);
    var sub = $(obj).children(big);
    $(mini).height(sub.height());
  });
}