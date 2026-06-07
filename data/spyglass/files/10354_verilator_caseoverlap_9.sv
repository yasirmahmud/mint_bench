module overlap_ex9;
  reg [1:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      2'b00, 2'b01: out = 1'b0;
      2'b00: out = 1'b1; // Overlap with 2'b00
      default: out = 1'b0;
    endcase
  end
endmodule
