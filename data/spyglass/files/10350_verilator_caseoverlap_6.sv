module overlap_ex6;
  reg [3:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      4'h0, 4'h1, 4'h2: out = 1'b0;
      4'h2, 4'h3, 4'h4: out = 1'b1; // Overlap with 4'h2
      default: out = 1'b0;
    endcase
  end
endmodule
