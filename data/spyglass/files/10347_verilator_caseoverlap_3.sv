module overlap_ex3;
  reg [2:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      3'b001: out = 1'b0;
      3'b001: out = 1'b1; // Duplicate explicit value
      3'b010: out = 1'b0;
      3'b011: out = 1'b0;
      default: out = 1'b0;
    endcase
  end
endmodule
