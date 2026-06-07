module overlap_ex16;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'b0?0: out = 1'b0;
      3'b?00: out = 1'b1; // Overlap with 3'b000
      default: out = 1'b0;
    endcase
  end
endmodule
