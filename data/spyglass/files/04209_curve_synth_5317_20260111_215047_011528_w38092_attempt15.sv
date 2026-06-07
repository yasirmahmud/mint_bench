module curve_synth_5317_20260111_215047_011528_w38092_attempt15 (
  input wire clk,
  input wire reset_n,
  input wire [3:0] data_in,
  output reg [3:0] data_out
);

  // SYNTH_5317 violation: This always block has timing control statements
  // in its sensitivity list (`posedge clk` and `negedge reset_n`),
  // and an assignment within it includes an embedded event control
  // (`@(negedge clk)`) in the RHS. This construct is not supported by synthesis.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      data_out <= 4'b0;
    end else begin
      data_out <= @(negedge clk) data_in; // Embedded event control on RHS
    end
  end

endmodule
