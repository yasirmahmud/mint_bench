module example_nevt_negedge();
  event my_event_neg;

  initial begin
    #20 -> my_event_neg; // Correctly triggers the event
  end

  always @(my_event_neg) begin
    $display("my_event_neg triggered!");
  end
endmodule
