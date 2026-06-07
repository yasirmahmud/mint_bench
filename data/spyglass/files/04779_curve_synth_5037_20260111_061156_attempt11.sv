module curve_synth_5037_20260111_061156_attempt11 (
  input wire in_cond, // 1-bit input
  output reg out_val_a,
  output reg out_val_b
);

  // Declare a 2-bit wire for the condition value.
  wire [1:0] condition_val; 

  // Combinational assignment to constrain 'condition_val'.
  // This ensures condition_val[1] (the MSB) is always 0.
  // Therefore, 'condition_val' can only take values 2'b00 (0) or 2'b01 (1).
  assign condition_val = {1'b0, in_cond};

  always @(*) begin
    // Initialize outputs to default values to avoid unintentional latches for any unassigned paths.
    out_val_a = 1'b0; 
    out_val_b = 1'b0;

    // TARGET SYNTH_5037 VIOLATION:
    // The condition `condition_val == 2'b10` is impossible to meet.
    // As defined by 'assign condition_val = {1'b0, in_cond};', 
    // condition_val[1] is always '0'.
    // The value 2'b10 (decimal 2) requires condition_val[1] to be '1', which is a contradiction.
    if (condition_val == 2'b00) begin // This branch is reachable (when in_cond is 0)
      out_val_a = 1'b1;
    end else if (condition_val == 2'b01) begin // This branch is reachable (when in_cond is 1)
      out_val_b = 1'b1;
    end else if (condition_val == 2'b10) begin // This branch condition is impossible to meet.
      // The statements within this 'else if' block are therefore unreachable.
      out_val_a = 1'bX; // This specific statement should trigger the violation.
      out_val_b = 1'bX;
    end
    // An 'else' block that would cover 2'b11 is intentionally omitted. 
    // The default assignments for out_val_a/b at the top of the always block ensure no latch is inferred for 2'b11,
    // and the violation is focused specifically on the '2'b10' condition as per the rule description.
  end

endmodule
