$(window).scroll(function() {
  var scrollTop = $(this).scrollTop();

  $('.navbar-lewagon').css({
    opacity: function() {
      var elementHeight = $(this).height(),
          opacity = ((1 - (elementHeight - scrollTop) / elementHeight) * 0.5) + 0.5;

      return opacity;
    }
  });
});
