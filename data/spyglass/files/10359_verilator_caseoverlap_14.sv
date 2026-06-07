module overlap_ex14;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'b0?0: out = 1'b0;
      3'b010: out = 1'b1; // Overlap with 3'b0?0 (specifically 3'b010)
      default: out = 1'b0;
    endcase
  end
endmodule
