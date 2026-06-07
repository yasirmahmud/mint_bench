module test_func_no_avac_2;

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

  // Fix for W528 (Variable set but not read) and for observability:
  // Add an initial block to display the results.
  initial begin
    #1; // Allow combinational assignments to settle
    $display("Function call with sel=2'b00 (val+1): result = %d", result_case_00);
    $display("Function call with sel=2'b10 (unassigned branch): result = %d (expected X or undefined)", result_case_10);
  end

endmodule
