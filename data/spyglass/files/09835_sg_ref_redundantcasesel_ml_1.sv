module RedundantCaseSel_ex1;
 wire [1:0] sel;
 wire out;
 always @(*) begin casex (sel) 2'b0x: out = 1'b0;
 2'b1x: out = 1'b1;
 default: out = 1'b0;
 endcasex end endmodule
