module curve_elab_3519_20260111_231003_588361_w49296_attempt17 (
  input clk,
  input reset,
  input in_a,
  input in_b,
  input sel_mux,
  output reg out_final
);

  wire mux_internal_out;
  reg M0_reg_q;

  // MUX instance named M0
  my_mux M0 (
    .A(in_a),
    .B(in_b),
    .SEL(sel_mux),
    .OUT(mux_internal_out)
  );

  // An always block with a named block 'M0'.
  // This block name conflicts with the MUX instance name 'M0' in the same scope.
  // The register 'M0_reg_q' is defined within this named block.
  always @(posedge clk or posedge reset) begin : M0
    if (reset) begin
      M0_reg_q <= 1'b0;
    end else begin
      M0_reg_q <= mux_internal_out;
    end
  end

  // Use the register output to avoid unused signal warnings
  assign out_final = M0_reg_q;

endmodule
