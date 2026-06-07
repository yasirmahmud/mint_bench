module overlap_ex11;
  reg [1:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      2'b01: out = 1'b0;
      2'b0?, 2'b1?: out = 1'b1; // Overlap with 2'b01 due to '?'
      default: out = 1'b0;
    endcase
  end
endmodule
