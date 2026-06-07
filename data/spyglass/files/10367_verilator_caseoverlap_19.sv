module overlap_ex19;
  reg [1:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      2'b0?: out = 1'b0;
      2'b00, 2'b01: out = 1'b1; // Overlap, as 2'b00 and 2'b01 are covered by 2'b0?
      default: out = 1'b0;
    endcase
  end
endmodule
