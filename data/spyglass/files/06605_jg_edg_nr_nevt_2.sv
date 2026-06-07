module example_nevt_negedge();
  event my_event_neg;

  initial begin
    #20 -> negedge my_event_neg; // Triggers EDG_NR_NEVT
  end

  always @(my_event_neg) begin
    $display("my_event_neg triggered!");
  end
endmodule
