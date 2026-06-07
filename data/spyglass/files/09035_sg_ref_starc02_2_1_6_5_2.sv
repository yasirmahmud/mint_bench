module my_module_ex2(input [1:0] in, output [7:0] out);
 reg [7:0] arr [0:3];
 reg [1:0] idx;
 initial begin idx = 2'b0x;
 end assign out = arr[idx];
 endmodule
