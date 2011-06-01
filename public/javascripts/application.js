// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $("#contact_birthday").datepicker({
    dateFormat: 'yy-mm-dd'
  });
  $("#contact_attend_since").datepicker({
    dateFormat: 'yy-mm-dd'
  });

  $("#contact_family_name").autocomplete({
    source: "/families",
    minLength: 3
  });

  $("#book_borrower_name_email").autocomplete({
    source: "/contacts",
    minLength: 3
  });

  $("#book_borrowed_date").datepicker({
    dateFormat: 'yy-mm-dd'
  });

  // TODO: problem on page reload with link_to
  //  $(".menu ul").delegate("li", "click", function() {
  //  $(this).toggleClass("current_page_item").siblings().removeClass("current_page_item");
  //});

  var path = location.pathname;

  if(path) 
    $('#access ul li a[href="' + path + '"]').parent().attr('class', 'current_page_item');

});


