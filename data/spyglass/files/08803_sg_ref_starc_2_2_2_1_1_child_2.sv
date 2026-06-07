module starc_2_2_2_1_ex1 (
  input a,
  input b,
  output reg out
);

  // Violation W122: 'b' was not in the sensitivity list. Added 'b'.
  // Violation W240: 'a' was declared but not read. 
  //   By making 'a' an enable for a transparent latch, 'a' is now explicitly read.
  // This resolves both violations by interpreting the ambiguous original code
  // as a standard transparent latch where 'a' is the enable.
  always @(a or b) begin
    if (a) begin
      out = b;
    end
    // 'out' implicitly holds its value when 'a' is low, forming a latch.
  end

endmodule
