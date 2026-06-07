module overlap_ex10;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'd0, 3'd1, 3'd2: out = 1'b0;
      3'd1: out = 1'b1; // Overlap with 3'd1
      default: out = 1'b0;
    endcase
  end
endmodule
