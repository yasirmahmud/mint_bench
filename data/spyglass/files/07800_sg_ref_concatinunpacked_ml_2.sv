module ConcatInUnpacked_ex2;
 reg [7:0] a, b;
 reg [7:0] my_unpacked_array [0:1];
 initial my_unpacked_array = {a, b};
 endmodule
