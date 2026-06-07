module example_nevt_posedge();
  event my_event_pos;

  initial begin
    #10 -> my_event_pos; // Triggers EDG_NR_NEVT
  end

  always @(my_event_pos) begin
    $display("my_event_pos triggered!");
  end
endmodule
