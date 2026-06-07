module curve_w422_20260111_224449_864478_w32456_attempt11 (
    input wire clk_A,
    input wire clk_B,
    input wire data_in,
    output reg data_out_reg
);

  // W422 violation: Block might be un-synthesizable due to event control
  // having more than one clock (posedge clk_A and posedge clk_B).
  // Synthesis tools typically do not support multiple independent clock edges
  // in a single sequential always block's sensitivity list.
  always @(posedge clk_A or posedge clk_B) begin
    data_out_reg <= data_in; // Simple data transfer to ensure 'data_out_reg' is used
  end

endmodule
