module constant_event_trigger_1 (
  output reg out_reg
);

  // This always block triggers on a constant value (1)
  always @(1) begin
    out_reg = ~out_reg;
  end

endmodule
