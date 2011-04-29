// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $("#contact_birthday").datepicker({
    dateFormat: 'yy-mm-dd'
  });

  // TODO: problem on page reload with link_to
  $(".menu ul").delegate("li", "click", function() {
    $(this).toggleClass("current_page_item").siblings().removeClass("current_page_item");
  });
});

