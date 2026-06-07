module curve_stx_ve_266_20260111_160447_003227_w11684_attempt3 (
  input wire clk,
  input wire rst,
  output reg out_data
);

  // This initial block attempts to deposit a value to a hierarchical reference
  // that is explicitly not defined within this module or any of its sub-modules.
  // This will cause SpyGlass to report a 'Cannot resolve hierarchical reference' violation (STX_VE_266).
  // The hierarchical path used here is distinct and clearly non-existent to trigger the rule.
  initial begin
    $deposit(non_existent_top.u_sub_a.u_sub_b.unresolvable_sig, 1'b0);
  end

  // Minimal RTL to prevent 'unused signal' or 'undriven output' warnings/violations
  // that could trigger other SpyGlass rules, ensuring only STX_VE_266 is reported.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_data <= 1'b0;
    end else begin
      out_data <= clk; // Simple assignment to prevent unused warnings
    end
  end

endmodule
