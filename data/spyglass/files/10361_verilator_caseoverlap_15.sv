module overlap_ex15;
  reg [1:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      2'b0?: out = 1'b0;
      2'b?1: out = 1'b1; // Overlap with 2'b01
      default: out = 1'b0;
    endcase
  end
endmodule
