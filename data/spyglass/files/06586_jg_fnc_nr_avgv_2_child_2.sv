module FNC_NR_AVGV_example_2 (
  input clk,
  input rst_n,
  output reg [3:0] func_output
);
  reg [3:0] module_state;

  // Fix for STARC05-2.1.3.1 (Bit-width mismatch) and W424 (Function should not set global variable)
  // The function is now a pure combinational function,
  // returning a 4-bit value and taking a 4-bit input.
  // The assignment to `module_state` has been removed to resolve W424, as functions should not have side effects.
  function [3:0] calculate_output_value;
    input [3:0] current_val_for_func; // Changed input to 4-bit to match module_state and resolve STARC05-2.1.3.1
    begin
      calculate_output_value = current_val_for_func * 2;
    end
  endfunction

  // Fix for SYNTH_5143 (Initial block ignored for synthesis) and
  // CheckDelayTimescale-ML (Delay used without timescale).
  // The `initial` block and `#5` delay are replaced by a synthesizable `always_ff` block
  // with explicit clock and reset inputs. This is the standard way to represent
  // initialization and sequential logic in synthesizable RTL.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      module_state <= 4'h1; // Initialize module_state to 1 on reset, matching original behavior
      func_output <= 4'h0;   // Reset func_output to a known state
    end else begin
      // In the original design, `module_state` was initialized to 1 and then
      // `process_and_set_state` was called. The side effect `module_state = current_val % 4`
      // inside the function would set `module_state` to `1 % 4 = 1`, which effectively did not change its value.
      // `func_output` received the value `1 * 2 = 2`.
      // This `always` block preserves that behavior: `module_state` is 1 after reset,
      // and `func_output` is updated on each clock edge based on this `module_state`.
      // Thus, on the first positive clock edge after reset, `func_output` will become 2.
      func_output <= calculate_output_value(module_state);
    end
  end

endmodule
