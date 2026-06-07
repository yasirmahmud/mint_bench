module curve_starc05_2_3_3_1_attempt11 (
  input wire clock_main,
  input wire clock_aux1,
  input wire clock_aux2,
  input wire data_in,
  output reg data_out
);

  // STARC05-2.3.3.1: Edges of multiple clocks used in the same always block.
  // This always block uses the positive edges of three distinct clock signals (clock_main, clock_aux1, clock_aux2),
  // directly triggering the violation for using multiple clock edges in a single sequential block.
  always @(posedge clock_main or posedge clock_aux1 or posedge clock_aux2) begin
    data_out <= data_in;
  end

endmodule
