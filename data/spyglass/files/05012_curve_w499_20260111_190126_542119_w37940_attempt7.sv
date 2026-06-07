module curve_w499_mod (
  input wire in_a,
  input wire in_b,
  output wire [3:0] out_val
);

  function [3:0] calc_val_w499;
    input wire cond;
    input wire [1:0] data_in;
    begin
      // In the 'if' branch, bits [3:2] of calc_val_w499 are not assigned.
      if (cond) begin
        calc_val_w499[1:0] = data_in;
      end
      // In the 'else' branch, bits [1:0] of calc_val_w499 are not assigned.
      else begin
        calc_val_w499[3:2] = data_in;
      end
      // Since neither branch fully assigns all bits of calc_val_w499,
      // this will trigger W499.
    end
  endfunction

  assign out_val = calc_val_w499(in_a, {in_b, in_a});

endmodule
