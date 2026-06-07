module curve_w336_20260111_155956_934715_w11684_attempt1 (
    input wire clk,
    input wire data_in,
    output reg  data_out
);

  // W336: Blocking assignment used inside a FlipFlop inferred sequential block
  always @(posedge clk) begin
    data_out = data_in; 
  end

endmodule
