CHECK_ME_OUT_360.home = {
  index_action: function() {
    $('.navbar').hide();
    $('#main_footer').hide();
    $('#profile_banner').hide();
    $('#inner_body').hide();
    $('.page-header').removeClass("partial_background");

    $('.page-header').addClass("full_background");
  },

  who_action: function() {
    $("#myCarousel").carousel({
      slid: function() {
        console.log('slid!!!!');
        $('#full_description_container').empty();
      }
    });
    $('a.display_description').click(function() {
      var id = $(this).data('id') + '_all_description';
      $('#full_description_container').empty().append($("#" + id).text())
    });
  }
}