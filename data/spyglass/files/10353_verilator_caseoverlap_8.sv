module overlap_ex8;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'b000: out = 1'b0;
      3'b001: out = 1'b1;
      3'b000: out = 1'b0; // Duplicate explicit value
      default: out = 1'b0;
    endcase
  end
endmodule
