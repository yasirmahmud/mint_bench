module curve_w499_20260111_223807_056638_w38092_attempt12 (
  input wire sel_cond,
  output wire [1:0] out_val
);

  // This function will trigger exactly one W499 violation.
  // The function returns a 2-bit value [1:0].
  // In both the 'if' and 'else' branches, only bit [1] is assigned.
  // Bit [0] is explicitly left unassigned in all execution paths,
  // leading to exactly one W499 occurrence.
  function [1:0] my_func_w499;
    input condition;
    begin
      if (condition) begin
        my_func_w499[1] = 1'b0; // Bit [0] is unassigned in this path
      end else begin
        my_func_w499[1] = 1'b1; // Bit [0] is also unassigned in this path
      end
      // Bit [0] of my_func_w499 is never assigned in any path.
    end
  endfunction

  assign out_val = my_func_w499(sel_cond);

endmodule
