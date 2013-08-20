function onSuccess(success){
  $(".container").replaceWith(success);
}
$(document).ready(function() {
  $("form").on("submit", function(event){
      event.preventDefault();
      var handle = $('#handle').serialize();
      console.log(handle);
      $.post("/gettweets", handle, onSuccess);
      $(".container").append('<img src="/spinner.gif">');
    });
});
