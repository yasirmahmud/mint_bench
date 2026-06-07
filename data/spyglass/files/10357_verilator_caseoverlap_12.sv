module overlap_ex12;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'b001: out = 1'b0;
      3'b0?1: out = 1'b1; // Overlap with 3'b001 due to '?'
      default: out = 1'b0;
    endcase
  end
endmodule
