module latch_example_2 (
  input logic [1:0] sel,
  input logic data_a,
  input logic data_b,
  output logic out_latch_case
);

  always_comb begin
    case (sel)
      2'b00: out_latch_case = data_a;
      2'b01: out_latch_case = data_b;
      // Latch inferred for out_latch_case if sel is 2'b10, 2'b11, or 'x'/'z'
    endcase
  end

endmodule
