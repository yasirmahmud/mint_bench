module RedundantCaseSel_ex1;
  wire [1:0] sel;
  reg out; // Changed from wire to reg to allow procedural assignment
  always @(*) begin
    casex (sel)
      2'b0x: out = 1'b0;
      2'b1x: out = 1'b1;
      default: out = 1'b0;
    endcase
  end
endmodule
