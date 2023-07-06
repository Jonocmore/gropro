    var scrollTop = $(this).scrollTop();
    console.log(scrollTop);

  $('.navbar-lewagon').css({
    opacity: function() {
      var elementHeight = $(this).height(),
          opacity = ((1 - (elementHeight - scrollTop) / elementHeight) * 0.5) + 0.5;

      return opacity;
      }
  });
