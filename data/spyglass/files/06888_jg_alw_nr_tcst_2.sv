module constant_event_trigger_2 (
  input wire in_data,
  output reg out_data
);

  // This always block triggers on the positive edge of a constant value (1)
  always @(posedge 1) begin
    out_data = in_data;
  end

endmodule
