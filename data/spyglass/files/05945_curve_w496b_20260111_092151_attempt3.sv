module curve_w496b_20260111_092151_attempt3 (
  input       [2:0] sel_in,
  output reg        out_reg
);

  always @(*) begin
    // Default assignment to avoid latches if not all paths are covered by specific cases.
    // However, the 'default' case within the 'case' statement ensures full coverage.
    out_reg = 1'b0; 

    case (sel_in) // Standard 'case' statement
      3'b000: out_reg = 1'b0;
      3'b001: out_reg = 1'b1;
      3'b010: out_reg = 1'b0;
      3'b011: out_reg = 1'b1;
      3'b100: out_reg = 1'b0;
      3'b101: out_reg = 1'b1;
      
      // This case item uses '?' which is equivalent to 'z' in Verilog-2001.
      // In a standard 'case' statement (unlike 'casez' or 'casex'), 'z' is treated
      // as a literal value for comparison, not a don't-care. Synthesis tools often
      // treat comparisons involving 'z' (or 'x') as resulting in an 'x', which is 
      // then interpreted as false in decision logic. This behavior triggers W496b.
      3'b0?1: out_reg = 1'b1; 
      
      default: out_reg = 1'b0; // Ensures all other combinations (including 'x' and 'z' inputs not matching above) are covered
    endcase
  end

endmodule
