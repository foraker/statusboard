var speed = 16000;
var wait  = 8000;

function scrollDown(el) {
    el.animate({
        scrollTop: el[0].scrollHeight-300
    }, speed, function() {
      setTimeout(function() {
        scrollUp(el)
      },wait)
    });
};

function scrollUp(el) {
    el.animate({
        scrollTop: 0
    }, speed, function() {
      setTimeout(function() {
        scrollDown(el)
      },wait)
    });
};

$(function() {
  scrollDown($("#feed"));
  scrollDown($("#git-feed"));
});
