module unused_event_var_2();
  event trigger_me;

  initial begin
    $display("This module does something, but 'trigger_me' is still unused.");
  end
  // trigger_me is declared but never triggered using '->'
endmodule
