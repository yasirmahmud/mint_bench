module overlap_ex17;
  reg [1:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      2'b00, 2'b0?: out = 1'b0; // 2'b00 is redundant within 2'b0?
      default: out = 1'b0;
    endcase
  end
endmodule
