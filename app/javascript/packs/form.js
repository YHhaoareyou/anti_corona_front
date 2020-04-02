jQuery(window).on('load', function () {
  $("#form_add_url_input_button").click(function() {
    $("#other_sns_url_inputs_div").append('<input class="form-control" type="text" name="post[other_sns_urls][]">');
  });

  $( "#new_post_form :input" ).change(function() {
    let filled_demand_inputs = $("#demand_inputs_div :input").filter(function() { return this.value != ""; });
    let filled_supply_inputs = $("#supply_inputs_div :input").filter(function() { return this.value != ""; });
    let filled_contact_inputs = $("#contact_inputs_div :input").filter(function() { return this.value != ""; });

    if (filled_demand_inputs.length > 0 && filled_supply_inputs.length > 0 && filled_contact_inputs.length > 0) {
      $('#form_submit').removeAttr("disabled");
    } else {
      $('#form_submit').attr("disabled", 'true');
    }
  });
});
