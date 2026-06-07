module test_func_no_avac_2;
  `timescale 1ns/1ps

  function automatic [3:0] my_func_case (input [1:0] sel, input [3:0] val);
    case (sel)
      2'b00: begin
        my_func_case = val + 1;
      end
      2'b01: begin
        my_func_case = val - 1;
      end
      2'b10: begin
        // Violation: my_func_case is not assigned in this branch
        // This branch is intentionally left unassigned to demonstrate FNC_NO_AVAC behavior.
        // Note: To fix FNC_NO_AVAC, one would typically assign a default or error value here, e.g., my_func_case = 4'hX;
      end
      default: begin
        my_func_case = val;
      end
    endcase
  endfunction

  // Fix for W415 (Multiple simultaneous drivers): Use separate wires for each function call.
  wire [3:0] result_case_00;
  wire [3:0] result_case_10;

  assign result_case_00 = my_func_case(2'b00, 4'd5);
  assign result_case_10 = my_func_case(2'b10, 4'd5); // This call will hit the unassigned path

  // Fix for W528 (Variable set but not read) in a synthesizable context:
  // Add a dummy synthesizable usage to ensure the wires are 'read' for synthesis tools.
  wire [3:0] dummy_usage_for_lint;
  assign dummy_usage_for_lint = result_case_00 ^ result_case_10;

  // The initial block is kept to preserve the described functional behavior (observability in simulation).
  // Note: SYNTH_5143 (Initial block is ignored for synthesis) will persist if this module is synthesized,
  // as initial blocks are non-synthesizable. This is acceptable for a test-like module's functional description.
  initial begin
    #1; // Allow combinational assignments to settle
    $display("Function call with sel=2'b00 (val+1): result = %d", result_case_00);
    $display("Function call with sel=2'b10 (unassigned branch): result = %d (expected X or undefined)", result_case_10);
    // Optional: Display dummy usage to confirm values are accessible if needed
    //$display("Dummy usage for linting: %d", dummy_usage_for_lint);
  end

endmodule
