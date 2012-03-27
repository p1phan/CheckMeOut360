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

function resize_block(block_1, block_2) {
  $('.center_block').each(function(index, obj) {
    b1 = $(obj).children(block_1);
    b2 = $(obj).children(block_2);
    console.log(b1.attr("class") + " || " + b2.attr("class") + " || " + b1.height() + " || " + b2.height());
    if (b1.height() > b2.height()) {
      b2.height(b1.height());
    }
    else if (b1.height() < b2.height()){
      b1.height(b2.height());
    }
    else {
    }
  });
}