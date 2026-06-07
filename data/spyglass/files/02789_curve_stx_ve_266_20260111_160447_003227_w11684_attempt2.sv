module curve_stx_ve_266_20260111_160447_003227_w11684_attempt2 (
  input wire clk,
  input wire rst,
  output reg out_valid
);

  // This initial block attempts to deposit a value to a hierarchical reference
  // that is explicitly not defined within this module or any of its sub-modules.
  // This will cause SpyGlass to report a 'Cannot resolve hierarchical reference' violation (STX_VE_266).
  // The hierarchical path used here is distinct and simpler than in attempt 1.
  initial begin
    $deposit(design_top.sub_inst_a.sub_inst_b.non_existent_signal_q, 1'b0);
  end

  // Minimal RTL to prevent 'unused signal' or 'undriven output' warnings/violations
  // that could trigger other SpyGlass rules, ensuring only STX_VE_266 is reported.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_valid <= 1'b0;
    end else begin
      out_valid <= ~out_valid;
    end
  end

endmodule
