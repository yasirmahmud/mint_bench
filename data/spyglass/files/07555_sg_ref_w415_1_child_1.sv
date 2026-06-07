module w415_ex1 (input clk, input a, input b, output reg out_reg);
  always @(posedge clk) begin
    // The original design had two separate always blocks driving 'out_reg',
    // which leads to multiple simultaneous drivers (W415) and a simulation race condition (sim_race02).
    // To resolve this, the assignments must be consolidated into a single always block.
    // When multiple non-blocking assignments occur to the same signal within a single procedural block
    // without conditional logic, the last assignment typically takes precedence.
    // Therefore, 'out_reg' will be driven by 'b' on each positive clock edge, resolving the conflict.
    // If the original intent was to conditionally assign 'a' or 'b', a select signal would be required,
    // but adding new ports is outside the scope of fixing linting violations while preserving existing interface.
    out_reg <= b;
  end
endmodule
