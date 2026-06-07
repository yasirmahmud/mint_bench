`define MY_MACRO 10 module stac05_1_1_4_4_ex1;
 reg [3:0] data;
 always @(*) begin data = `MY_MACRO;
 end endmodule
