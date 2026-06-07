module overlap_ex14 (
  input  [2:0] sel, // Fix: Declared as input to resolve undriven signal violation
  output reg   out   // Fix: Declared as output to resolve 'set but not read' violation
);

  always @(sel) begin
    // Fix: Changed to casez to correctly interpret '?' as a don't-care
    // and reordered specific cases before general cases to resolve overlap and ambiguity.
    casez (sel)
      3'b010:  out = 1'b1; // Specific case for 010, takes precedence
      3'b0?0:  out = 1'b0; // Covers 3'b000. '?' matches 0 or 1. Since 3'b010 is handled, this now covers 3'b000.
      default: out = 1'b0; // Default case for all other values
    endcase
  end
endmodule
