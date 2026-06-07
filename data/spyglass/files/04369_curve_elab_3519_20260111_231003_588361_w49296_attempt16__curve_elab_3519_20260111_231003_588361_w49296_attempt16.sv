module curve_elab_3519_20260111_231003_588361_w49296_attempt16 (
  input clk,
  input reset,
  input in_val_a,
  input in_val_b,
  input sel_mux,
  output reg out_final
);

  wire mux_out;

  // MUX instance named M0
  my_mux M0 (
    .A(in_val_a),
    .B(in_val_b),
    .SEL(sel_mux),
    .OUT(mux_out)
  );

  // Register named M0, which conflicts with the MUX instance name
  reg M0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      M0 <= 1'b0;
    end else begin
      M0 <= mux_out;
    end
  end

  // Use the register M0 to avoid unused signal warning
  assign out_final = M0;

endmodule
