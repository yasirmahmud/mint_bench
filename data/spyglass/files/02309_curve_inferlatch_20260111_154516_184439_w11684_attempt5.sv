module lemming (
  input wire [2:0] data_in,
  input wire enable_latch,
  output wire [2:0] latched_output
);

  reg [2:0] ns; // This register will infer a latch

  always @(data_in or enable_latch) begin
    if (enable_latch == 1'b1) begin // Latch is transparent when enable_latch is high
      ns = data_in; // ns follows data_in
    end
    // Else (if enable_latch is 1'b0), ns holds its previous value, inferring a latch.
  end

  assign latched_output = ns;

endmodule
