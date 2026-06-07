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
      end
      default: begin
        my_func_case = val; // This would prevent the violation, but we'll leave 2'b10 unassigned
      end
    endcase
  endfunction

  wire [3:0] result_case;
  assign result_case = my_func_case(2'b00, 4'd5);
  assign result_case = my_func_case(2'b10, 4'd5); // This call will hit the unassigned path

endmodule
