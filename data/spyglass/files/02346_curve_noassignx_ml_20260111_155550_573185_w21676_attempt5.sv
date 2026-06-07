module curve_noassignx_ml_20260111_155550_573185_w21676_attempt5 (
  input wire clk,
  input wire rst_n,
  output reg out_reg
);

  // Assigning '1'bx' in the reset condition of a synchronous block
  // directly triggers the NoAssignX-ML violation for "Initialization to 'x'".
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'bx; // Target violation: RHS contains 'X'
    end else begin
      out_reg <= 1'b0;
    end
  end

endmodule
