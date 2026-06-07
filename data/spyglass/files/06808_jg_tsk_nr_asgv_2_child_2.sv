module module_tsk_nr_asgv_2 (
  input logic clk,
  input logic rst_n
);
  logic [3:0] shared_register;

  // Fix for W426: Pass shared_register as an inout argument to resolve the warning
  // "Global variable 'shared_register' should not be 'set' in task".
  // This ensures the task operates on its arguments rather than directly on module-level variables.
  task modify_shared_reg(inout logic [3:0] reg_to_modify, input logic [3:0] value_in);
    reg_to_modify = value_in;
  endtask

  // To resolve SYNTH_5143 ("Initial block is ignored for synthesis"),
  // the initial block is replaced with a synthesizable always_ff block.
  // The original initial block effectively sets shared_register to 4'hF
  // (shared_register = 4'h0; then modify_shared_reg(..., 4'hF);).
  // This behavior is now captured as a reset value for the register.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Active low reset
      shared_register <= 4'hF; // Initialize register to the final value from the original initial block
    end
    // No 'else' branch is added here as there are no other synchronous updates
    // to shared_register defined in the original module beyond its initial state.
  end

  // The $display statement from the initial block is removed as it is a simulation-only construct
  // and does not contribute to the synthesizable functional behavior.

endmodule
