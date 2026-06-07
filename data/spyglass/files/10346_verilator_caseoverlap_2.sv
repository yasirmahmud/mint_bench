module overlap_ex2;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'd1: out = 1'b0;
      3'd1: out = 1'b1; // Duplicate explicit value
      3'd2: out = 1'b0;
      default: out = 1'b0;
    endcase
  end
endmodule
