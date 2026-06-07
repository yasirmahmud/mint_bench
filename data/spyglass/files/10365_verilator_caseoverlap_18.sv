module overlap_ex18;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'b001, 3'b0?1: out = 1'b0; // 3'b001 is redundant within 3'b0?1
      default: out = 1'b0;
    endcase
  end
endmodule
