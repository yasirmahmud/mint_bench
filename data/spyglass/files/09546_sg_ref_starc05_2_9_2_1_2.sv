module my_module_ex2;
 reg [7:0] data;
 reg [7:0] result;
 integer i;
 initial begin data = 8'hAA;
 for (i=0; i<10; i=i+1) begin result = data + 1;
 end end endmodule
