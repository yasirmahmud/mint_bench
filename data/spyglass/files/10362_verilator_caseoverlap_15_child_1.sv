module overlap_ex15;
  reg [1:0] sel;
  reg out;

  always @(sel) begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b0; // Originally covered by 2'b0? due to precedence
      2'b11: out = 1'b1;
      default: out = 1'b0;
    endcase
  end
endmodule
