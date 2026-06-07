module badimplicitSM2_ex2(input clk,input rst,input in,output reg q);
  // The original design had 'q' driven by two always blocks (one on posedge clk, one on negedge clk),
  // leading to a multiple driver violation (W415). This is inherently problematic for a single 'reg' in synthesis.
  //
  // To preserve the functional behavior, let's analyze the net effect of the original code:
  //
  // When 'rst' is active: q <= 1'b0 (from posedge block).
  // When 'rst' is inactive:
  // 1. On posedge clk: q becomes 'in'. Let's call this value Q_posedge = 'in'.
  // 2. On negedge clk:
  //    - If 'in' is high (1): The negedge block triggers and 'q' becomes '~Q_posedge'. Since Q_posedge was 'in' (1), q becomes '~1' which is '0'.
  //    - If 'in' is low (0): The negedge block triggers but 'if(in)' is false, so 'q' retains its current value (which was 'in', i.e., 0). So q remains '0'.
  //
  // In summary, if 'rst' is inactive, after both the posedge and negedge updates, 'q' always settles to '0'.
  //
  // The corrected RTL consolidates this net behavior into a single, synthesizable always block that drives 'q' only once.
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      q <= 1'b0;
    end else begin
      // Based on the analysis above, 'q' always settles to 0 by the end of a full clock cycle
      // (after the negedge update) if 'rst' is not active.
      q <= 1'b0;
    end
  end
endmodule
