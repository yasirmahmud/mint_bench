module curve_w336_20260111_155956_934715_w11684_attempt2 (
    input wire clk,
    input wire enable,
    output reg [7:0] data_reg
);

  // Initialize data_reg at reset or power-up
  initial begin
    data_reg = 8'd0;
  end

  // W336: Blocking assignment used inside a FlipFlop inferred sequential block
  always @(posedge clk) begin
    if (enable) begin
      data_reg = data_reg + 8'd1; // This blocking assignment will trigger W336
    end
  end

endmodule
