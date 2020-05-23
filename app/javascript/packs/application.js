// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// = require jquery
// = require jquery_ujs
// = require_tree 
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)]
console.log("Hey Bro")
$(document).ready(function() {
    if ($('.pagination').length) {
        $(window).scroll(function() {
            var url = $('.pagination .next_page a').attr('href');
            console.log(url)
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 100) {
                console.log("new page : ", url);
                $('.pagination').text("Please Wait...");
                return $.getScript(url);
            }
        });
        return $(window).scroll();
    }
});

// http://127.0.0.1:3000/user_profile/1?page=3