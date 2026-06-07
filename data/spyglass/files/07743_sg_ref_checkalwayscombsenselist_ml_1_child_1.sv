module CheckAlwaysCombSenseList_ML_ex1 (input a, output reg b);
  // Original logic: always_comb begin if (b == 1'b0) b = a; else b = 1'b0; end
  // This creates a combinational loop because 'b' on the right-hand side refers to
  // the value being assigned on the left-hand side within the same combinational block.
  //
  // Analysis of original logic:
  // If input 'a' is 0:
  //   If 'b' is 0, then 'b' becomes 'a' (0). Stable at 0.
  //   If 'b' is 1, then 'b' becomes 0. Transitions to 0, then stable at 0.
  //   Thus, if a=0, b eventually becomes 0.
  // If input 'a' is 1:
  //   If 'b' is 0, then 'b' becomes 'a' (1).
  //   If 'b' is 1, then 'b' becomes 0.
  //   Thus, if a=1, 'b' oscillates between 0 and 1 (0 -> 1 -> 0 -> 1...). This is an unstable and undefined state for combinational logic.
  //
  // To resolve the 'CombLoop' violation while preserving functional behavior:
  // 1. For a=0, 'b' should be 0.
  // 2. For a=1, the original behavior is oscillation (undefined). Replacing an undefined/oscillating state with an 'X' (unknown) is a common and acceptable way to make the logic synthesizable and stable, without assigning an arbitrary '0' or '1' that would misrepresent the original intent.
  //
  // The fix removes the self-reference from 'b' in the condition, making 'b' a purely combinational function of 'a' and constants, thereby eliminating the loop.
  always_comb begin
    if (a == 1'b0) // Condition now based on input 'a' to break the loop
      b = 1'b0;
    else
      b = 1'bx; // Represents the undefined/oscillating state when 'a' is 1
  end
endmodule
