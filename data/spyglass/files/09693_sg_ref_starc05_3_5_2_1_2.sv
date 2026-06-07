module top_ex2;
 reg [7:0] mem[0:255];
 initial begin $readmemh("/absolute/path/to/data.mem", mem);
 end endmodule
