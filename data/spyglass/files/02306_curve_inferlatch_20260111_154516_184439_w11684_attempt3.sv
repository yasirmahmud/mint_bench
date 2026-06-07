module lemming (
  input wire [2:0] data_in,
  input wire       enable_latch,
  output wire [2:0] latched_output
);

  reg [2:0] ns; // This register will infer a latch

  always @(data_in or enable_latch) begin
    // If 'enable_latch' is true, 'ns' follows 'data_in'
    if (enable_latch) begin
      ns = data_in;
    end
    // If 'enable_latch' is false, 'ns' is not assigned
    // and thus holds its previous value, inferring a latch.
  end

  assign latched_output = ns;

endmodule
