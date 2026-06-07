module curve_starc05_2_3_3_1_20260111_191008_029119_w7792_attempt9 (
    input wire clk_a,
    input wire clk_b,
    input wire data_in,
    output reg data_out
);

  // STARC05-2.3.3.1: Edges of multiple clocks used in the same always block.
  // This always block uses posedge clk_a and posedge clk_b, triggering the violation.
  always @(posedge clk_a or posedge clk_b) begin
    data_out <= data_in;
  end

endmodule
