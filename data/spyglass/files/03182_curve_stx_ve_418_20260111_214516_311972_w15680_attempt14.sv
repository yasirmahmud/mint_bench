module curve_stx_ve_418_20260111_214516_311972_w15680_attempt14 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  reg internal_d_reg;

  always @(posedge clk) begin
    internal_d_reg <= data_in;
    data_out <= internal_d_reg;
  end

  specify
    // STX_VE_418 violation occurs here:
    // 'clk' is a primary input port and is directly used as the source
    // of a timing path in the specify block. The rule requires that the source
    // of a path must be driven by an internal gate output, not directly by a primary input.
    (clk => internal_d_reg) = 1ps;
  endspecify

endmodule
