module curve_w499_mod (
  input in_a,        // 1-bit input for condition
  input in_b,        // 1-bit input for data
  output [3:0] out_val // 4-bit output to assign function result
);

  // Function definition: calc_val_w499 returns a 4-bit value.
  function [3:0] calc_val_w499;
    input cond;      // 1-bit condition input for the function
    input [1:0] data_in; // 2-bit data input for the function
    begin
      // This 'if' block demonstrates W499 because no single execution path
      // assigns all bits of 'calc_val_w499'.
      if (cond) begin
        // If 'cond' is true, only bits [1:0] of calc_val_w499 are assigned.
        // Bits [3:2] are left unassigned in this branch.
        calc_val_w499[1:0] = data_in;
      end
      else begin
        // If 'cond' is false, only bits [3:2] of calc_val_w499 are assigned.
        // Bits [1:0] are left unassigned in this branch.
        calc_val_w499[3:2] = data_in;
      end
      // Consequently, regardless of the value of 'cond',
      // either bits [3:2] or bits [1:0] of calc_val_w499 will be unassigned,
      // leading to the W499 violation.
    end
  endfunction

  // Assign the module output by calling the function.
  // 'in_a' (1-bit) maps to 'cond' (1-bit).
  // '{in_b, in_a}' (2-bit concatenation) maps to 'data_in' (2-bit).
  assign out_val = calc_val_w499(in_a, {in_b, in_a});

endmodule
