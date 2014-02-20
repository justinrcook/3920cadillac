//= require bootstrap/

// Scroll to the top of the carousel window when clicking on one of the thumbnails
$('.photos a.thumbnail').on("click", function(event){
  $('html,body').animate({scrollTop:$("#carousel").offset().top}, 200);
});

// Pause the carousel since there isn't a data attribute available
$("a[data-slide='pause']").on("click", function(event){
  $("#carousel").carousel("pause");
});