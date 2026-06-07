module w337_ex1 (input [1:0] sel, output reg out);
  always @(*) begin
    // SpyGlass violations were due to using a floating-point number (2.5)
    // as a case label for an integer selector ('sel').
    // A 2-bit selector 'sel' can only take integer values 0, 1, 2, or 3.
    // Since 'sel' can never equal 2.5, the original design would always
    // execute the 'default' case, setting 'out' to 1'b0.
    // The functional behavior is preserved by directly assigning 1'b0 to 'out'.
    out = 1'b0;
  end
endmodule
