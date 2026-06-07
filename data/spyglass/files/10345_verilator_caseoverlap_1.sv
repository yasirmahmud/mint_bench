module overlap_ex1;
  reg [1:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      2'b01: out = 1'b0;
      2'b01: out = 1'b1; // Duplicate explicit value
      default: out = 1'b0;
    endcase
  end
endmodule
