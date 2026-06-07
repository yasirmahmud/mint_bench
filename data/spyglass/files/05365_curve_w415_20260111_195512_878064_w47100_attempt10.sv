module curve_w415_20260111_195512_878064_w47100_attempt10 (
  input wire clk,
  input wire reset_n,
  input wire data_in_a,
  input wire data_in_b,
  output wire result_out
);

  // This 'reg' will be the target of multiple simultaneous drivers,
  // causing the W415 violation.
  reg shared_reg;

  // First always block driving 'shared_reg'.
  // It has a synchronous reset and updates on posedge clk.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      shared_reg <= 1'b0;
    end else begin
      shared_reg <= data_in_a; // Drives shared_reg with data_in_a
    end
  end

  // Second always block simultaneously driving the SAME 'shared_reg'.
  // This block is sensitive to posedge clk. When clk rises, and reset_n is high,
  // both always blocks attempt to drive 'shared_reg' at the same time,
  // creating the multiple driver condition (W415).
  always @(posedge clk) begin
    shared_reg <= data_in_b; // Drives shared_reg with data_in_b
  end

  // Use all inputs (data_in_a, data_in_b, clk, reset_n) and the shared_reg
  // to prevent unused signal warnings. The output itself is driven cleanly
  // by a single continuous assignment.
  assign result_out = shared_reg ^ (data_in_a & data_in_b) ^ (clk | reset_n);

endmodule
