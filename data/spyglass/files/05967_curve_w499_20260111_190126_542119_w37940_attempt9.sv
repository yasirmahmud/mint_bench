module curve_w499_mod (
  input [1:0] sel_in,     // 2-bit selector input for the function's case statement
  input data_bit,       // 1-bit data input for the function
  output [2:0] result_out // 3-bit output to assign the function result
);

  // Function definition: my_func_w499 returns a 3-bit value.
  // This function will trigger W499 because no single execution path
  // assigns all 3 bits of its return value.
  function [2:0] my_func_w499;
    input [1:0] select_arg; // Internal argument for the case condition
    input data_arg;     // Internal argument for the bit assignments
    begin
      // In each case branch, certain bits of my_func_w499 are explicitly assigned.
      // However, no branch assigns all three bits [2:0].
      // This ensures that regardless of the 'select_arg' value,
      // at least one bit of 'my_func_w499' remains unassigned for that path.
      case (select_arg)
        2'b00: begin
          // Assigns bit [0], bits [2:1] are unassigned in this branch.
          my_func_w499[0] = data_arg;
        end
        2'b01: begin
          // Assigns bit [1], bits [2] and [0] are unassigned in this branch.
          my_func_w499[1] = data_arg;
        end
        2'b10: begin
          // Assigns bit [2], bits [1:0] are unassigned in this branch.
          my_func_w499[2] = data_arg;
        end
        default: begin // This covers the case 2'b11
          // Assigns bits [0] and [1], bit [2] is unassigned in this branch.
          my_func_w499[0] = data_arg;
          my_func_w499[1] = ~data_arg;
        end
      endcase
      // Since every path leaves some bits unassigned, SpyGlass W499 is triggered.
    end
  endfunction

  // Assign the module output by calling the function.
  // 'sel_in' (2-bit) maps to 'select_arg' (2-bit).
  // 'data_bit' (1-bit) maps to 'data_arg' (1-bit).
  assign result_out = my_func_w499(sel_in, data_bit);

endmodule
