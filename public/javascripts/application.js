// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $("#user_contact_tokens").tokenInput("/contacts.json", {
    prePopulate: $("#user_contact_tokens").data("pre")
  });

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

  $("#contact_show_emails").click(function(e) {
    e.preventDefault();
    $("#contact_email_alias").show();
    $(this).hide();
  }); 

  $("#contact_hide_emails").click(function(e) {
    e.preventDefault();
    $("#contact_email_alias").hide();
    $("#contact_show_emails").show();
  }); 

  $("#book_borrower_name_email").autocomplete({
    source: "/contacts",
    minLength: 3
  });

  $("#book_borrowed_date").datepicker({
    dateFormat: 'yy-mm-dd'
  });


  var path = location.pathname.split("/");
  var menu_path = path[1];
  if(path[1] == "groups" && path[3] == "contacts") {
    menu_path = "contacts";
  } else if(path[1] == "categories" && path[3] == "posts") {
    menu_path = "posts";
  } else if(path[1] == "groups" || path[1] == "statuses" || path[1] == "categories" || path[1] == "families" || path[2] == "removed") {
    menu_path = "users";
  }

  if(menu_path != "") {
    $('#access ul li').removeClass("current_page_item");
    $('#access ul li a[href="/' + menu_path + '"]').parent().attr('class', 'current_page_item');
  }


});


