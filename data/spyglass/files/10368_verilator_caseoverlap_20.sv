module overlap_ex20;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'b0??: out = 1'b0;
      3'b000, 3'b001: out = 1'b1; // Overlap, as 3'b000 and 3'b001 are covered by 3'b0??
      default: out = 1'b0;
    endcase
  end
endmodule
